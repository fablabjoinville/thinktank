# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  cnpj       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Company < ApplicationRecord
  has_many :people

  validates :name, presence: true
  validates :cnpj, uniqueness: true
  validates_cnpj_format_of :cnpj
end
