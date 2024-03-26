class Meeting < ApplicationRecord
  belongs_to :phase
  has_many :events, dependent: :restrict_with_error

  validates :name, presence: true

  scope :ordered_by_name, -> { order('LOWER(name) ASC') }

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"name\")")
  end

  def self.ransackable_associations(auth_object = nil)
    ['phase']
  end

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'name']
  end

  def to_s
    "#{phase.name} - #{name}"
  end
end
