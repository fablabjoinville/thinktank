class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false, default: ""
      t.references :axis, null: false, foreign_key: true
      t.string :link_teams, null: false, default: ""
      t.string :link_miro, null: false, default: ""

      t.timestamps
    end
  end
end
