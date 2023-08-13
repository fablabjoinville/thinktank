# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meeting_id :bigint           not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_events_on_meeting_id  (meeting_id)
#  index_events_on_team_id     (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (team_id => teams.id)
#
class Event < ApplicationRecord
  belongs_to :meeting

  belongs_to :team
  has_many :members, through: :team

  has_many :attendances, dependent: :destroy
  has_many :attending_members, through: :attendances, source: :member

  accepts_nested_attributes_for :attendances, allow_destroy: true

  validates :name, presence: true
  validates :date, presence: true

  after_create :create_attendances_for_members!

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"name\")")
  end

  def to_s
    team.name
  end

  def create_attendances_for_members!
    members.each do |member|
      attendances.find_or_create_by!(member: member)
    end
  end

  def attendances_counts
    total = members.count
    present = attendances.present.count
    absent = attendances.absent.count

    "#{total} esperados - #{present} presentes - #{absent} faltas"
  end
end
