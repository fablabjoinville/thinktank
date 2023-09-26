class ToolEventAssessment < ApplicationRecord
  belongs_to :tool
  belongs_to :event

  enum score: {
    pessimo: 0,
    ruim: 1,
    bom: 2,
    otimo: 3,
  }

  validates :score, presence: true
  validates :comment, length: { maximum: 280 }
  validates :comment, presence: true, if: -> { [:pessimo, :ruim].include?(score&.to_sym) }
end
