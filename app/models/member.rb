# == Schema Information
#
# Table name: members
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE), not null
#  role       :integer          default("sol"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :bigint           not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_members_on_person_id  (person_id)
#  index_members_on_team_id    (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (team_id => teams.id)
#
class Member < ApplicationRecord
  belongs_to :team
  belongs_to :person

  has_one :company, through: :person

  enum :role, [:mm, :mp, :sol], prefix: true, default: :sol

  delegate :full_name, :company, to: :person

  def to_s
    company_name = company.present? ? "| #{company.name}" : ""
    "#{humanized_enum(:role)} | #{full_name}#{company_name}"
  end
end
