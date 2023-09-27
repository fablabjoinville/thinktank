class AddAssessmentFieldsToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :item_a_score, :integer
    add_column :events, :item_a_comment, :text, default: "", null: false
    add_column :events, :item_b_score, :integer
    add_column :events, :item_b_comment, :text, default: "", null: false
    add_column :events, :item_c_score, :integer
    add_column :events, :item_c_comment, :text, default: "", null: false
    add_column :events, :item_d_score, :integer
    add_column :events, :item_d_comment, :text, default: "", null: false
    add_column :events, :general_comments, :text, default: "", null: false
  end
end
