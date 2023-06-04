class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :person, null: false, foreign_key: true
      t.references :meeting, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.text :reason, null: false, default: ""

      t.timestamps
    end

    add_index :attendances, [:person_id, :meeting_id], unique: true
  end
end
