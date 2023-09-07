class Meeting < ApplicationRecord
  belongs_to :phase

  validates :name, presence: true

  scope :ordered_by_name, -> { order('LOWER(name) ASC') }

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"name\")")
  end

  def to_s
    "#{phase.name} - #{name}"
  end
end
