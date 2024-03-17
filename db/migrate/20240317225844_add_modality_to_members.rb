class AddModalityToMembers < ActiveRecord::Migration[7.1]
  def up
    add_column :members, :modality, :integer, default: 0

    Member.all.each do |member|
      cluster = member.team.clusters.first
      member.update!(modality: cluster&.modality || 2)
    end
  end

  def down
    remove_column :members, :modality
  end
end
