# == Schema Information
#
# Table name: events
#
#  id                :bigint           not null, primary key
#  date              :date             not null
#  general_comments  :text             default(""), not null
#  item_a_assessment :integer          default(1), not null
#  item_a_comment    :text             default(""), not null
#  item_b_assessment :integer          default(1), not null
#  item_b_comment    :text             default(""), not null
#  item_c_assessment :integer          default(1), not null
#  item_c_comment    :text             default(""), not null
#  item_d_assessment :integer          default(1), not null
#  item_d_comment    :text             default(""), not null
#  ref               :integer          not null
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  team_id           :bigint           not null
#
# Indexes
#
#  index_events_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
