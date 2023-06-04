# == Schema Information
#
# Table name: people
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(TRUE), not null
#  address                :string           default(""), not null
#  authorization_level    :integer          default("facilitator"), not null
#  birthday               :date
#  celular_number         :string           default(""), not null
#  cpf                    :string           default("")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string           not null
#  gender                 :integer          default("other"), not null
#  nickname               :string           default(""), not null
#  phone_number           :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  rg                     :string           default("")
#  role                   :integer          default(0), not null
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint
#  team_id                :bigint
#
# Indexes
#
#  index_people_on_company_id            (company_id)
#  index_people_on_cpf                   (cpf) UNIQUE WHERE (((cpf)::text <> ''::text) AND (cpf IS NOT NULL))
#  index_people_on_email                 (email) UNIQUE
#  index_people_on_reset_password_token  (reset_password_token) UNIQUE
#  index_people_on_rg                    (rg) UNIQUE WHERE (((rg)::text <> ''::text) AND (rg IS NOT NULL))
#  index_people_on_team_id               (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (team_id => teams.id)
#
primary key
#  authorization_level    :integer          default("facilitator"), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'should be valid' do
    user = User.new(
      email: 'test@example.com',
      password: 'password',
      full_name: 'Test Name',
      cpf: '12345678900',
      rg: '12345678',
      gender: 'man'
    )

    assert user.valid?
  end

  test 'email should be present' do
    user = User.new(password: 'password')
    assert @user.invalid?
  end

  test 'password should be present' do
    user = User.new(email: 'test@example.com')
    assert user.invalid?
  end
end
