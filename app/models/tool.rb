class Tool < ApplicationRecord
  has_many :tool_event_assessment, dependent: :destroy
  has_many :events, through: :tool_event_assessment

  has_and_belongs_to_many :phases

  validates :name, presence: true, uniqueness: true

  scope :ordered_by_name, -> { order('LOWER(name) ASC') }

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"name\")")
  end
end
