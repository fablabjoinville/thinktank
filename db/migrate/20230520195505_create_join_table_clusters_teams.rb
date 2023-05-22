class CreateJoinTableClustersTeams < ActiveRecord::Migration[7.0]
  def change
    create_join_table :clusters, :teams do |t|
      # t.index [:cluster_id, :team_id]
      # t.index [:team_id, :cluster_id]
    end
  end
end
