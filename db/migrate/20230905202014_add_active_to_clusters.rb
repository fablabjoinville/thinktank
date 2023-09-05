class AddActiveToClusters < ActiveRecord::Migration[7.0]
  def change
    add_column :clusters, :active, :boolean, default: true, null: false
  end
end
