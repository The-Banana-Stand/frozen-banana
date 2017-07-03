class CreateGeneralAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :general_availabilities do |t|
      t.belongs_to :user
      t.integer :block
      t.integer :day
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
