# == Schema Information
#
# Table name: tools
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tool < ApplicationRecord
  has_and_belongs_to_many :phases
  validates :name, presence: true, uniqueness: true

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"name\")")
  end
end
