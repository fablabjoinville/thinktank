# == Schema Information
#
# Table name: tools
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tool < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
