# == Schema Information
#
# Table name: axes
#
#  id          :bigint           not null, primary key
#  description :text             default(""), not null
#  title       :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Axis < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
end
