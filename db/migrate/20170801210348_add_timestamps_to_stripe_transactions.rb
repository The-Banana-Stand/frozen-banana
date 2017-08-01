class AddTimestampsToStripeTransactions < ActiveRecord::Migration[5.1]
  def change

    add_column :stripe_transactions, :created_at, :datetime
    add_column :stripe_transactions, :updated_at, :datetime
    change_column_null :stripe_transactions, :created_at, false, Time.zone.now
    change_column_null :stripe_transactions, :updated_at, false, Time.zone.now

    add_column :users, :created_at, :datetime
    change_column_null :users, :created_at, false, Time.zone.now
  end


end
