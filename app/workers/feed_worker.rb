require 'open-uri'

class FeedWorker
  include Sidekiq::Worker

  def perform(*args)
    all_rss = args[0].present? ? [Rss.find(args[0])] : Rss.all
    all_rss.each do |rss|
      begin
        ap 'worker for Feed started'
        # @page = Nokogiri::HTML(open(rss.rss_url)).css('rss channel item')
        @page = Nokogiri::HTML(open(rss.rss_url)).css('item')
        ap @page.count
        @page.each do |feed|
          title = feed.css('title').text
          href = feed.css('guid').text
          published_at = feed.css('pubdate').text.to_datetime
          rss_feed = rss.feeds.find_by_title(title) || rss.feeds.find_by_href_url(href) rescue ''
          if rss_feed.present?
            rss_feed.update_attrbiutes(title: title, href_url: href, published_at: published_at)
          else
            rss.feeds.create(title: title, href_url: href, published_at: published_at)
          end
        end
        ap 'worker for Feed stopped'
      rescue StandardError
        next
      end
    end
  end
end
