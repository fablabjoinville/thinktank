class ChangeColumnsInClusters < ActiveRecord::Migration[7.0]
  def change
    change_column :clusters, :person_id, :bigint, null: true
    change_column :clusters, :modality, :integer, null: false, default: 0
  end
end
