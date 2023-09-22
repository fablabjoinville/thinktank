class Axis < ApplicationRecord
  has_many :teams, dependent: :restrict_with_error

  validates :title, presence: true
  validates :description, presence: true

  ransacker :title, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"title\")")
  end
end
