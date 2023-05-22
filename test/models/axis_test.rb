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
require "test_helper"

class AxisTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
