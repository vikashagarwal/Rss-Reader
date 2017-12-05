# == Schema Information
#
# Table name: feeds
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  href_url     :string           not null
#  published_at :datetime         not null
#  rss_id       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Feed < ActiveRecord::Base
	belongs_to :rss
end
