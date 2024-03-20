class RenamePersonIdToUserIdOnMembers < ActiveRecord::Migration[7.1]
  def change
    rename_column(:members, :person_id, :user_id)
  end
end
