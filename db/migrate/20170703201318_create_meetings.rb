class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.integer :dm_id
      t.integer :sp_id
      t.string :status
      t.integer :price
      t.string :payment_status
      t.string :dm_calendar_status
      t.string :sp_calendar_status
      t.date :date
      t.time :time_start
      t.time :time_end

      t.timestamps
    end
  end
end
