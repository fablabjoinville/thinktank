class CreateClusters < ActiveRecord::Migration[7.0]
  def change
    create_table :clusters do |t|
      t.references :person, null: false, foreign_key: true
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.integer :week_day, null: false
      t.string :address
      t.integer :modality, null: false
      t.text :link

      t.timestamps
    end
  end
end
