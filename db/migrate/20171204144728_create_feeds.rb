class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
    	t.string :title, null: false
    	t.string :href_url, null: false
      t.datetime :published_at, null: false
    	t.references :rss, index: true

      t.timestamps null: false
    end
  end
end
