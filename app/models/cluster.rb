class Cluster < ApplicationRecord
  belongs_to :user, foreign_key: 'person_id', class_name: 'User'
  has_and_belongs_to_many :teams

  validates :start_time, presence: true
  validates :end_time, presence: true, comparison: { greater_than: :start_time }
  validates :end_date, comparison: { greater_than: :start_date }, if: -> { start_date.present? }
  validates :week_day, presence: true
  validates :modality, presence: true

  enum modality: [:presencial, :online]
  enum week_day: [:segunda, :terca, :quarta, :quinta, :sexta, :sabado, :domingo]

  def self.ransackable_associations(auth_object = nil)
    ['user']
  end

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'name', 'week_day']
  end

  def start_time
    read_attribute(:start_time)&.strftime('%H:%M')
  end

  def end_time
    read_attribute(:end_time)&.strftime('%H:%M')
  end

  def to_s
    day_s = humanized_enum(:week_day)
    modality_s = humanized_enum(:modality)
    facilitador_s = user.full_name
    starttime_s = start_time
    "#{day_s}, #{starttime_s} | #{facilitador_s} | #{modality_s}"
  end
end
