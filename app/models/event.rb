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

  SCORE_OPTIONS = { pessimo: 0, ruim: 1, bom: 2, otimo: 3 }
  enum item_a_score: SCORE_OPTIONS, _prefix: :item_a
  enum item_b_score: SCORE_OPTIONS, _prefix: :item_b
  enum item_c_score: SCORE_OPTIONS, _prefix: :item_c
  enum item_d_score: SCORE_OPTIONS, _prefix: :item_d

  validates :name, presence: true
  validates :date, presence: true
  validates :item_a_score, presence: true, on: :update, if: -> { item_a_score_changed? || item_a_comment_changed? }
  validates :item_a_comment, length: { maximum: 280 }, on: :update
  validates :item_a_comment, presence: true, if: -> { [:pessimo, :ruim].include?(item_a_score&.to_sym) }, on: :update
  validates :item_b_score, presence: true, on: :update, if: -> { item_b_score_changed? || item_b_comment_changed? }
  validates :item_b_comment, length: { maximum: 280 }, on: :update
  validates :item_b_comment, presence: true, if: -> { [:pessimo, :ruim].include?(item_b_score&.to_sym) }, on: :update
  validates :item_c_score, presence: true, on: :update, if: -> { item_c_score_changed? || item_c_comment_changed? }
  validates :item_c_comment, length: { maximum: 280 }, on: :update
  validates :item_c_comment, presence: true, if: -> { [:pessimo, :ruim].include?(item_c_score&.to_sym) }, on: :update
  validates :item_d_score, presence: true, on: :update, if: -> { item_d_score_changed? || item_d_comment_changed? }
  validates :item_d_comment, length: { maximum: 280 }, on: :update
  validates :item_d_comment, presence: true, if: -> { [:pessimo, :ruim].include?(item_d_score&.to_sym) }, on: :update
  validates :general_comments, length: { maximum: 280 }, on: :update

  after_initialize -> { self.date = Date.current }, if: -> { new_record? && date.nil? }
  before_validation -> { self.name = meeting.name }, on: :create
  after_create :create_attendances_for_members!

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"name\")")
  end

  def self.ransackable_associations(auth_object = nil)
    ['meeting', 'team']
  end

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'name', 'date']
  end

  def to_s
    name
  end

  def assessment
    [
     {
        item: I18n.t("activerecord.attributes.event.item_a_score"),
        score: item_a_score,
        comment: item_a_comment
      },
      {
        item: I18n.t("activerecord.attributes.event.item_b_score"),
        score: item_b_score,
        comment: item_b_comment
      },
      {
        item: I18n.t("activerecord.attributes.event.item_c_score"),
        score: item_c_score,
        comment: item_c_comment
      },
      {
        item: I18n.t("activerecord.attributes.event.item_d_score"),
        score: item_d_score,
        comment: item_d_comment
      }
    ]
  end

  def attendances_counts
    total = attendances.count
    present = attendances.present.count
    absent = attendances.absent.count

    "#{total} esperados - #{present} presentes - #{absent} faltas"
  end

  private

  def create_attendances_for_members!
    members.each do |member|
      attendances.find_or_create_by!(member: member)
    end
  end
end
