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
class Attendance < ApplicationRecord
  belongs_to :member
  belongs_to :event

  validates :member, presence: true
  validates :event, presence: true
  validates :status, presence: true
  validates :reason, presence: true, if: ->{ absent? }

  validates_uniqueness_of :member_id, scope: :event_id, message: "presença já registrada para esse membro nesse evento"

  enum status: [:not_registered, :present, :absent]
end
