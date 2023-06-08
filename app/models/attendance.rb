# == Schema Information
#
# Table name: attendances
#
#  id         :bigint           not null, primary key
#  reason     :text             default(""), not null
#  status     :integer          default("not_registered"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meeting_id :bigint           not null
#  person_id  :bigint           not null
#
# Indexes
#
#  index_attendances_on_meeting_id                (meeting_id)
#  index_attendances_on_person_id                 (person_id)
#  index_attendances_on_person_id_and_meeting_id  (person_id,meeting_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (person_id => people.id)
#
class Attendance < ApplicationRecord
  belongs_to :person
  belongs_to :meeting

  validates :person, presence: true
  validates :meeting, presence: true
  validates :status, presence: true
  validates :reason, presence: true, if: ->{ absent? }

  validates_uniqueness_of :person_id, scope: :meeting_id, message: "presença já registrada para esse membro nesse encontro"

  enum status: [:not_registered, :present, :absent]
end
