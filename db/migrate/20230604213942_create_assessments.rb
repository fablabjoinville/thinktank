class CreateAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments do |t|
      t.references :assessmentable, polymorphic: true, null: false
      t.references :author, polymorphic: true, null: false

      t.integer :item_a_assessment, null: false, default: 1
      t.text :item_a_comment, null: false, default: ""
      t.integer :item_b_assessment, null: false, default: 1
      t.text :item_b_comment, null: false, default: ""
      t.integer :item_c_assessment, null: false, default: 1
      t.text :item_c_comment, null: false, default: ""
      t.integer :item_d_assessment, null: false, default: 1
      t.text :item_d_comment, null: false, default: ""
      t.text :general_comments, null: false, default: ""

      t.timestamps
    end
  end
end
