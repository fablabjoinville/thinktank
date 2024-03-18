class AddClusterIdToTeam < ActiveRecord::Migration[7.1]
  def up
    add_reference :teams, :cluster, null: true, foreign_key: true

    Team.all.each do |team|
      if team.clusters.any?
        team.update(cluster_id: team.clusters.first.id)
      end
    end
  end

  def down
    remove_reference :teams, :cluster, foreign_key: true
  end
end
