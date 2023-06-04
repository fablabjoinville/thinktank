class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.references :team, null: false, foreign_key: true
      t.string :title, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
