class AddPaymentOptionToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :payment_option, :integer, default: 0, null: false
  end
end
