class Cluster < ApplicationRecord
  belongs_to :chapter
  belongs_to :user, foreign_key: 'person_id', class_name: 'User'
  has_many :teams

  validates :start_time, presence: true
  validates :end_time, presence: true, comparison: { greater_than: :start_time }
  validates :end_date, comparison: { greater_than: :start_date }, if: -> { start_date.present? }
  validates :week_day, presence: true

  enum week_day: [:segunda, :terca, :quarta, :quinta, :sexta, :sabado, :domingo]

  scope :filtered_by_latest_year, -> { joins(:chapter).where(chapters: { edition_year: Chapter.latest_year }) }
  scope :ordered_by_week_day, -> { order('week_day ASC') }

  def self.ransackable_associations(auth_object = nil)
    ['user']
  end

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'week_day']
  end

  def start_time
    read_attribute(:start_time)&.strftime('%H:%M')
  end

  def end_time
    read_attribute(:end_time)&.strftime('%H:%M')
  end

  def name
    day_s = humanized_enum(:week_day)
    facilitador_s = user.full_name
    starttime_s = start_time
    "#{day_s}, #{starttime_s} | #{facilitador_s}"
  end
  alias :to_s :name
end
