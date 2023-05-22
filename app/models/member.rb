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
class Member < ApplicationRecord
  belongs_to :team
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances

  accepts_nested_attributes_for :attendances, allow_destroy: true

  validates :full_name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates_cpf_format_of :cpf
  validates :rg, presence: true, uniqueness: true
  validates :phone_number, phone: { allow_blank: true, types: :fixed_line }
  validates :celular_number, phone: { allow_blank: true, types: :mobile }

  enum :gender, [:man, :woman, :other], prefix: true, default: :other
  enum :role, [:mm, :mp, :sol], prefix: true, default: :sol

  def to_s
     full_name
  end

  def attendance_status_for(event)
    status = Attendance.humanized_enum_value(:status, attendances.where(event: event).first.status)
    "Participação: #{status}"
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
end
