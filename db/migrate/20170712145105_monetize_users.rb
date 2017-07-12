class MonetizeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :price_cents, :integer, default: 10426, null: false
    add_column :users, :price_currency, :string, default: 'USD', null: false
  end
end
