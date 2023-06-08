# == Schema Information
#
# Table name: members
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE), not null
#  role       :integer          default("sol"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :bigint           not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_members_on_person_id  (person_id)
#  index_members_on_team_id    (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (team_id => teams.id)
#
class Member < ApplicationRecord
  belongs_to :team
  belongs_to :person

  has_one :company, through: :person

  has_many :meetings, through: :team
  has_many :attendances, through: :person

  accepts_nested_attributes_for :attendances, allow_destroy: true

  enum :role, [:mm, :mp, :sol], prefix: true, default: :sol

  delegate :full_name, :company, to: :person

  after_create :create_attendances_for_meetings!

  def to_s
    company_name = company.present? ? "| #{company.name}" : ""
    "#{humanized_enum(:role)} | #{full_name}#{company_name}"
  end

  def attendance_status_for(meeting)
    status = Attendance.humanized_enum_value(:status, attendances.where(meeting: meeting).first.status)
    "Participação: #{status}"
  end

  private

  def create_attendances_for_meetings!
    team.meetings.each do |meeting|
      meeting.attendances.find_or_create_by!(person: person)
    end
  end
end
