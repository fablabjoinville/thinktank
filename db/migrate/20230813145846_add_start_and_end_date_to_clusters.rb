class AddStartAndEndDateToClusters < ActiveRecord::Migration[7.0]
  def change
    add_column :clusters, :start_date, :date
    add_column :clusters, :end_date, :date
  end
end
