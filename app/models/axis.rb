class Axis < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  ransacker :title, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"title\")")
  end
end
