class RemoveUniqueIndexFromEmailOnPeople < ActiveRecord::Migration[7.0]
  def change
    remove_index :people, name: "index_people_on_email"
  end
end
