class Phase < ApplicationRecord
  has_many :meetings, dependent: :restrict_with_error
  has_and_belongs_to_many :tools

  validates :name, presence: true, uniqueness: true

  scope :ordered_by_name, -> { order('LOWER(name) ASC') }

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql('unaccent("phases"."name")')
  end

  def self.ransackable_associations(auth_object = nil)
    ['tools']
  end

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'name']
  end
end
