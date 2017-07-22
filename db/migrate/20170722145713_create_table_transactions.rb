class CreateTableTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_transactions do |t|
      t.integer :amount
      t.integer :dm_cut
      t.integer :platform_cut
      t.integer :amount_refunded
      t.text :status
      t.text :stripe_id
      t.text :description
      t.text :failure_code
      t.text :failure_message
      t.boolean :paid
      t.boolean :refunded
      t.boolean :captured
      t.belongs_to :meeting, index: true
      t.integer :payer_id
      t.integer :payee_id

    end
  end
end
