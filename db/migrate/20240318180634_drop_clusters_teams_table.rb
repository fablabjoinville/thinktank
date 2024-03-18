class DropClustersTeamsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :clusters_teams do |t|
      t.belongs_to :cluster, null: false, foreign_key: true
      t.belongs_to :team, null: false, foreign_key: true
    end
  end
end
