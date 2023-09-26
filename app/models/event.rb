class Event < ApplicationRecord
  belongs_to :meeting

  belongs_to :team
  has_many :members, through: :team

  has_many :attendances, dependent: :destroy
  has_many :attending_members, through: :attendances, source: :member

  has_many :tool_event_assessments, dependent: :destroy
  has_many :tools, through: :tool_event_assessments

  accepts_nested_attributes_for :attendances, allow_destroy: true
  accepts_nested_attributes_for :tool_event_assessments, allow_destroy: true

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
