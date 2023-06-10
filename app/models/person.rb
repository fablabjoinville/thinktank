# == Schema Information
#
# Table name: people
#
#  id                     :bigint           not null, primary key
#  address                :string           default(""), not null
#  authorization_level    :integer          default(0), not null
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
class Person < ApplicationRecord
  belongs_to :company, optional: true

  has_one :attendance, dependent: :destroy

  has_and_belongs_to_many :events

  has_many :members
  has_many :teams, through: :members

  has_one_attached :image

  validates :full_name, presence: true
  validates :cpf, uniqueness: { allow_blank: true }
  validates_cpf_format_of :cpf, { allow_blank: true }
  validates :rg, uniqueness: { allow_blank: true }
  validates :phone_number, phone: { allow_blank: true, types: :fixed_line }
  validates :celular_number, phone: { allow_blank: true, types: :mobile }

  enum :gender, [:man, :woman, :other], prefix: true, default: :other

  ransacker :address, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"address\")")
  end

  ransacker :full_name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"full_name\")")
  end

  ransacker :nickname, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"nickname\")")
  end

  def type
    case self[:type]
      when "User"
        "Time Interno"
      when "Member"
        "Membro de Equipe"
      else
        "Pessoa Física"
    end
  end

  def to_s
    full_name
  end

  def name
    full_name
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
