class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :full_name, null: false
      t.string :email, null: false, default: ""
      t.date :birthday
      t.string :nickname, null: false, default: ""
      t.string :cpf, unique: true
      t.string :rg, unique: true
      t.string :phone_number, null: false, default: ""
      t.string :celular_number, null: false, default: ""
      t.string :address, null: false, default: ""
      t.integer :gender, null: false, default: 2
      t.boolean :active, null: false, default: true
      t.integer :role, null: false, default: 0

      t.timestamps
    end

    add_index :members, :cpf, unique: true
    add_index :members, :rg, unique: true
  end
end
