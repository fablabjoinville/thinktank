class CreateMember < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.references :team, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.boolean :active, null: false, default: true
      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end
