class RemoveTeamIdFromPeople < ActiveRecord::Migration[7.1]
  def change
    remove_reference :people, :team, foreign_key: true
  end
end
