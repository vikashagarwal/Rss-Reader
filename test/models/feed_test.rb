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

require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
