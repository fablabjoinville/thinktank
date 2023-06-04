class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.date :date, null: false
      t.integer :ref, null: false

      t.timestamps
    end
  end
end
