class CreateAxes < ActiveRecord::Migration[7.0]
  def change
    create_table :axes do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""

      t.timestamps
    end
  end
end
