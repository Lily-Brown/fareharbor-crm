class CreateMeetings < ActiveRecord::Migration[5.0]
  def change
    create_table :meetings do |t|
      t.text :name
      t.text :agenda
      t.text :location
      t.time :time
      t.date :date
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
