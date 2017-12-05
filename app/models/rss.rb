# == Schema Information
#
# Table name: rsses
#
#  id         :integer          not null, primary key
#  rss_url    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rss < ActiveRecord::Base
	has_many :feeds, dependent: :destroy
end
