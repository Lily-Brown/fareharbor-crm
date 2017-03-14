class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :work_phone
      t.string :email_address
      t.belongs_to :customer

      t.timestamps
    end
  end
end
