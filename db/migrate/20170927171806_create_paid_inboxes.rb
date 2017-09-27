class CreatePaidInboxes < ActiveRecord::Migration[5.1]
  def up
    create_table :paid_inboxes do |t|

      t.belongs_to :user
      t.integer :status, null: false, default: 0
      t.integer :delivery_frequency, null: false, default: 0
      t.integer :price_cents, default: 300, null: false
      t.string :price_currency, default: "USD", null: false
      t.integer :price_option, null: false, default: 0

      t.timestamps
    end
  end

  def down
    drop_table :paid_inboxes
  end
end
