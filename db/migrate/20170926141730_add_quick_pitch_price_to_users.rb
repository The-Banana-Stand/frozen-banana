class AddQuickPitchPriceToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :quick_pitch_price_cents, :integer, default: 1700, null: false
    add_column :users, :quick_pitch_price_currency, :string, default: 'USD', null: false
  end

  def down
    remove_column :users, :quick_pitch_price_cents
    remove_column :users, :quick_pitch_price_currency
  end
end
