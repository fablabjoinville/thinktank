# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Event < ApplicationRecord

  has_and_belongs_to_many :people
  has_one :assessment, as: :assessmentable, dependent: :destroy

  validates :title, presence: true
  validates :date, presence: true

  ransacker :title, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"title\")")
  end

  def to_s
    "#{title} - #{formatted_date}"
  end

  def formatted_date
    date.strftime('%d/%m/%Y')
  end
end
