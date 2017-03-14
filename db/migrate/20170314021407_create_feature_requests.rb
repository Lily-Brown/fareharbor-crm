class CreateFeatureRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :feature_requests do |t|
      t.date :request_date
      t.belongs_to :contact
      t.belongs_to :customer
      t.text :customer_summary
      t.integer :status

      t.timestamps
    end
  end
end
