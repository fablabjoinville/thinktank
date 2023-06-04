# == Schema Information
#
# Table name: assessments
#
#  id                  :bigint           not null, primary key
#  assessmentable_type :string           not null
#  author_type         :string           not null
#  general_comments    :text             default(""), not null
#  item_a_assessment   :integer          default(1), not null
#  item_a_comment      :text             default(""), not null
#  item_b_assessment   :integer          default(1), not null
#  item_b_comment      :text             default(""), not null
#  item_c_assessment   :integer          default(1), not null
#  item_c_comment      :text             default(""), not null
#  item_d_assessment   :integer          default(1), not null
#  item_d_comment      :text             default(""), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  assessmentable_id   :bigint           not null
#  author_id           :bigint           not null
#
# Indexes
#
#  index_assessments_on_assessmentable  (assessmentable_type,assessmentable_id)
#  index_assessments_on_author          (author_type,author_id)
#
class Assessment < ApplicationRecord
end
