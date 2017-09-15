class CreateBids < ActiveRecord::Migration[5.1]
  def up
    create_table :bids do |t|
      t.belongs_to :user
      t.belongs_to :meeting_queue
      t.boolean :can_rebid, default: false
      t.integer :status, default: 0, null: false
      t.monetize :price, amount: { null: true, default: nil }
      t.timestamps
    end
  end

  def down
    drop_table :bids
  end
end
