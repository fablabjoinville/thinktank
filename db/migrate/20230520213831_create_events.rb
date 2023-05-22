class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :team, null: false, foreign_key: true
      t.string :title, null: false
      t.date :date, null: false
      t.integer :ref, null: false

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
