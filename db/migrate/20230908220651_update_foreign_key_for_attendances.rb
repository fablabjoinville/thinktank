class UpdateForeignKeyForAttendances < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :attendances, :members
    add_foreign_key :attendances, :members, on_delete: :cascade
  end
end
