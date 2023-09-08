class Member < ApplicationRecord
  belongs_to :team
  belongs_to :person

  has_one :attendance, dependent: :destroy
  has_one :company, through: :person

  enum :role, [:mm, :mp, :sol], prefix: true, default: :sol

  delegate :avatar_path, :full_name, :email, :company, :celular_number, :phone_number, to: :person

  def to_s
    company_name = company.present? ? "| #{company.name}" : ""
    "#{humanized_enum(:role)} | #{full_name}#{company_name}"
  end
end
