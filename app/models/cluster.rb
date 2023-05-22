# == Schema Information
#
# Table name: clusters
#
#  id         :bigint           not null, primary key
#  address    :string
#  end_time   :time             not null
#  link       :text
#  modality   :integer          not null
#  start_time :time             not null
#  week_day   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_clusters_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Cluster < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :teams

  validates :user, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :week_day, presence: true
  validates :modality, presence: true
  # validates :link, allow_blank: true

  enum week_day: [:segunda, :terca, :quarta, :quinta, :sexta, :sabado, :domingo]
  enum modality: [:presencial, :online]

  def to_s
    start_time_s = start_time.strftime('%H:%M')
    end_time_s = end_time.strftime('%H:%M')
    "Cluster #{humanized_enum(:week_day)}: #{start_time_s} - #{end_time_s} | #{humanized_enum(:modality)}"
  end
end
