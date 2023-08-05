# == Schema Information
#
# Table name: clusters
#
#  id         :bigint           not null, primary key
#  address    :string
#  end_time   :time             not null
#  link       :text
#  modality   :integer          default("presencial"), not null
#  start_time :time             not null
#  week_day   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :bigint
#
# Indexes
#
#  index_clusters_on_person_id  (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#
class Cluster < ApplicationRecord
  belongs_to :user, foreign_key: 'person_id', class_name: 'User'
  has_and_belongs_to_many :teams

  validates :start_time, presence: true
  validates :end_time, presence: true, comparison: { greater_than: :start_time }
  validates :week_day, presence: true
  validates :modality, presence: true

  enum modality: [:presencial, :online]
  enum week_day: [:segunda, :terca, :quarta, :quinta, :sexta, :sabado, :domingo]

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
