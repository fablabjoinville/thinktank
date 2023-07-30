class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.references :phase, null: true, foreign_key: true

      t.string :name, null: false

      t.timestamps
    end
  end
end
