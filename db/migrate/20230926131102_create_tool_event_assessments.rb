class CreateToolEventAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :tool_event_assessments do |t|
      t.references :tool, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :score
      t.text :comment

      t.timestamps
    end
  end
end
