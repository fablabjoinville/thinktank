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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates_cpf_format_of :cpf
  validates :rg, presence: true, uniqueness: true
  validates :phone_number, phone: { allow_blank: true, types: :fixed_line }
  validates :celular_number, phone: { allow_blank: true, types: :mobile }

  enum :authorization_level, [:super_admin, :admin, :facilitator], suffix: true, default: :facilitator
  enum :gender, [:man, :woman, :other], prefix: true, default: :other

  attr_accessor :skip_password_validation

  def to_s
    "#{humanized_enum(:authorization_level)}: #{full_name}"
  end

  def cpf=(cpf)
    return if cpf.blank?
    write_attribute(:cpf, CPF.new(cpf).formatted)
  end

  def celular_number=(celular_number)
    return if celular_number.blank?
    write_attribute(:celular_number, Phonelib.parse(celular_number).local_number)
  end

  def phone_number=(phone_number)
    return if phone_number.blank?
    write_attribute(:phone_number, Phonelib.parse(phone_number).local_number)
  end

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
