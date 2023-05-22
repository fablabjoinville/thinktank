# == Schema Information
#
# Table name: members
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE), not null
#  address        :string           default(""), not null
#  birthday       :date
#  celular_number :string           default(""), not null
#  cpf            :string
#  email          :string           default(""), not null
#  full_name      :string           not null
#  gender         :integer          default("other"), not null
#  nickname       :string           default(""), not null
#  phone_number   :string           default(""), not null
#  rg             :string
#  role           :integer          default("sol"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  team_id        :bigint
#
# Indexes
#
#  index_members_on_cpf      (cpf) UNIQUE
#  index_members_on_rg       (rg) UNIQUE
#  index_members_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
require "test_helper"

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
