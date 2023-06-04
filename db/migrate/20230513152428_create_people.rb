# frozen_string_literal: true

class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.boolean :active, default: true, null: false
      t.date :birthday
      t.integer :gender, default: 2, null: false # 2 corresponds to "other"
      t.string :address, default: "", null: false
      t.string :celular_number, default: "", null: false
      t.string :cpf, default: "", null: true
      t.string :full_name, null: false
      t.string :nickname, default: "", null: false
      t.string :phone_number, default: "", null: false
      t.string :rg, default: "", null: true
      t.string :type, null: false

      ## Member

      t.integer :role, null: false, default: 0

      ## Devise User

      ## Database authenticatable
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false

      t.integer :authorization_level, null: false, default: 0
    end

    add_index :people, :cpf, unique: true, where: "cpf != '' AND cpf IS NOT NULL"
    add_index :people, :rg, unique: true, where: "rg != '' AND rg IS NOT NULL"

    add_index :people, :email,                unique: true
    add_index :people, :reset_password_token, unique: true
  end
end
