class Person < ApplicationRecord
  belongs_to :company, optional: true

  has_many :members
  has_many :teams, through: :members

  has_one_attached :image

  validates :cpf, uniqueness: { allow_blank: true }
  validates_cpf_format_of :cpf, { allow_blank: true }
  validates :email, uniqueness: { allow_blank: true }
  validates :full_name, presence: true
  validates :rg, uniqueness: { allow_blank: true }
  validates :phone_number, phone: { allow_blank: true, types: :fixed_line }
  validates :celular_number, phone: { allow_blank: true, types: :mobile }

  # 0 1 2 3 4
  enum :authorization_level, [:person, :secretary, :facilitator, :admin, :super_admin], suffix: true, default: :facilitator
  enum :gender, [:man, :woman, :other], prefix: true, default: :other

  scope :internal_team, -> { where(authorization_level: [:secretary, :facilitator, :admin, :super_admin]) }
  scope :ordered_by_full_name, -> { order('LOWER(full_name) ASC') }

  ransacker :address, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"address\")")
  end

  ransacker :full_name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"full_name\")")
  end

  ransacker :nickname, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"nickname\")")
  end

  def self.ransackable_associations(auth_object = nil)
    ['company']
  end

  def self.ransackable_attributes(auth_object = nil)
    ['address', 'cpf', 'full_name', 'id', 'nickname', 'rg']
  end

  def user?
    type == "User"
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

  def avatar_path
    image&.attached? ? image : "default-avatar.png"
  end
end
