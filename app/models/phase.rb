# == Schema Information
#
# Table name: phases
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Phase < ApplicationRecord
  has_many :meetings

  validates :name, presence: true, uniqueness: true
end
