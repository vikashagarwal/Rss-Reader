class FeedWorker
  include Sidekiq::Worker

  def perform(*args)
    ap 'Feed started'
    all_rss = args[0].present? ? [Rss.find(args[0])] : Rss.all
    all_rss.each do |rss|
      # @page = Nokogiri::HTML(open(rss.rss_url)).css('rss channel item')
      @page = Nokogiri::HTML5.get(rss.rss_url).css('item')
      ap @page.count
      titles = @page.css('title')
      hrefs = @page.css('guid')
      published_ats = @page.css('pubDate')
      (0..@page.count-1).each do |index|
        begin
          title = (titles[index].text.split('<![CDATA[') - [''])[0].split(']]>')[0] rescue ''
          href = hrefs[index].present? ? hrefs[index].text : @page[index].at('link').next_sibling.text
          published_at = published_ats[index].text.to_datetime rescue ''
          rss_feed = rss.feeds.find_by_title(title) || rss.feeds.find_by_href_url(href)
          if rss_feed.present?
            rss_feed.update_attributes(title: title, href_url: href, published_at: published_at)
            ap 'successfully updated the rss feed'
          else
            rss.feeds.create(title: title, href_url: href, published_at: published_at)
            ap 'successfully created the rss feed'
          end
        rescue Exception => e
          ap e.message
          next
        end
      end
      ap 'Feed stopped'
    end
  end
end
