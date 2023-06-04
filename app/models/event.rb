# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  ref        :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Event < ApplicationRecord

  enum ref: [:p, :e]

  validates :title, presence: true
  validates :date, presence: true
  validates :ref, presence: true

  def to_s
    "#{title} - #{formatted_date}"
  end

  def formatted_date
    date.strftime('%d/%m/%Y')
  end
end
