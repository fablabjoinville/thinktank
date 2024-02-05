class CreateChapters < ActiveRecord::Migration[7.1]
  def change
    create_table :chapters do |t|
      t.string :title
      t.boolean :shared
      t.integer :edition_year

      t.timestamps
    end

    add_reference :clusters, :chapter, foreign_key: true
  end
end
