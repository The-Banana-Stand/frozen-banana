class MonetizeMeetings < ActiveRecord::Migration[5.1]
  def change
    rename_column :meetings, :price, :price_cents
    add_column :meetings, :price_currency, :string, default: 'USD', null: false
  end
end
