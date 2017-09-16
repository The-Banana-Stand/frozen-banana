class CreateQueue < ActiveRecord::Migration[5.1]
  def up
    create_table :meeting_queues do |t|
      t.belongs_to :user
      t.datetime :last_scheduled_at
      t.integer :meeting_frequency, default: 0, null: false
      t.integer :minimum_bid_cents, default: 1000
      t.string :minimum_bid_currency, default: "USD", null: false
      t.timestamps
    end
  end

  def down
    drop_table :meeting_queues
  end
end
