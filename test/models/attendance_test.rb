# == Schema Information
#
# Table name: attendances
#
#  id         :bigint           not null, primary key
#  reason     :text             default(""), not null
#  status     :integer          default("not_registered"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  member_id  :bigint           not null
#
# Indexes
#
#  index_attendances_on_event_id                (event_id)
#  index_attendances_on_member_id               (member_id)
#  index_attendances_on_member_id_and_event_id  (member_id,event_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (member_id => members.id)
#
require "test_helper"

class AttendanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
