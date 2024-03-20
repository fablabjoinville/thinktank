class RenamePersonIdToUserIdOnClusters < ActiveRecord::Migration[7.1]
  def change
    rename_column(:clusters, :person_id, :user_id)
  end
end
