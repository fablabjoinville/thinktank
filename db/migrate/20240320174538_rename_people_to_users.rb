class RenamePeopleToUsers < ActiveRecord::Migration[7.1]
  def change
    rename_table :people, :users
  end
end
