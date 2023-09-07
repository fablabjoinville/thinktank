class Company < ApplicationRecord
  has_many :people

  validates :name, presence: true
  validates :cnpj, uniqueness: true
  validates_cnpj_format_of :cnpj

  scope :ordered_by_name, -> { order('LOWER(name) ASC') }

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"name\")")
  end
end
