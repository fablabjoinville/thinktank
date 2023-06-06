class CreatePhases < ActiveRecord::Migration[7.0]
  def change
    create_table :phases do |t|
      t.string :name, null: false, default: ''

      t.timestamps
    end

    create_table :phases_tools do |t|
      t.references :phase, null: false, foreign_key: true
      t.references :tool, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :meetings, :phase, null: true, foreign_key: true
  end
end
