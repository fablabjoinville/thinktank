# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  link_miro  :string           default(""), not null
#  link_teams :string           default(""), not null
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  axis_id    :bigint           not null
#
# Indexes
#
#  index_teams_on_axis_id  (axis_id)
#
# Foreign Keys
#
#  fk_rails_...  (axis_id => axes.id)
#
require "test_helper"

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
