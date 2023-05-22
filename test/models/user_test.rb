# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string           default(""), not null
#  authorization_level    :integer          default("facilitator"), not null
#  birthday               :date
#  celular_number         :string           default(""), not null
#  cpf                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string           not null
#  gender                 :integer          default("other"), not null
#  nickname               :string           default(""), not null
#  phone_number           :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  rg                     :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_cpf                   (cpf) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_rg                    (rg) UNIQUE
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