class Phase < ApplicationRecord
  has_many :meetings, dependent: :restrict_with_error
  has_and_belongs_to_many :tools

  validates :name, presence: true, uniqueness: true

  scope :ordered_by_name, -> { order('LOWER(name) ASC') }

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"name\")")
  end
end
