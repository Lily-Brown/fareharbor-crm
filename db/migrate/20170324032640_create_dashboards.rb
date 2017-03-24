class CreateDashboards < ActiveRecord::Migration[5.0]
  def change
    create_table :dashboards do |t|
      t.integer :order
      t.integer :feature_request_id
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
