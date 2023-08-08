# == Schema Information
#
# Table name: meetings
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phase_id   :bigint
#
# Indexes
#
#  index_meetings_on_phase_id  (phase_id)
#
# Foreign Keys
#
#  fk_rails_...  (phase_id => phases.id)
#
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
