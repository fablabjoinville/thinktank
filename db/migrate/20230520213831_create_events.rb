class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.date :date, null: false

      t.timestamps
    end

    create_table :events_people, id: false do |t|
      t.belongs_to :event
      t.belongs_to :person
    end
  end
end
