class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :cnpj, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_reference :people, :company, foreign_key: true
  end
end
