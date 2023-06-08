# == Schema Information
#
# Table name: meetings
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phase_id   :bigint
#  team_id    :bigint           not null
#
# Indexes
#
#  index_meetings_on_phase_id  (phase_id)
#  index_meetings_on_team_id   (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (phase_id => phases.id)
#  fk_rails_...  (team_id => teams.id)
#
class Meeting < ApplicationRecord
  belongs_to :phase, optional: true
  belongs_to :team

  has_one :assessment, as: :assessmentable, dependent: :destroy

  has_many :attendances, dependent: :destroy
  has_many :members, through: :team
  has_many :attending_members, through: :attendances, source: :member

  accepts_nested_attributes_for :attendances, allow_destroy: true

  validates :title, presence: true
  validates :date, presence: true

  after_create :create_attendances_for_members!

  ransacker :title, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"title\")")
  end

  def to_s
    "#{title} - #{formatted_date}"
  end

  def formatted_date
    date.strftime('%d/%m/%Y')
  end

  def attendances_counts
    total = team.members.count
    present = attendances.present.count
    absent = attendances.absent.count

    "#{total} esperados - #{present} presentes - #{absent} faltas"
  end

  private

  def create_attendances_for_members!
    members.each do |member|
      attendances.find_or_create_by!(person: member.person)
    end
  end
end
