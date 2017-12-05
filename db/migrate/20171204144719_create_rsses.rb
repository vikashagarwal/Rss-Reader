class CreateRsses < ActiveRecord::Migration
  def change
    create_table :rsses do |t|
			t.string :rss_url, null: false

      t.timestamps null: false
    end
  end
end
