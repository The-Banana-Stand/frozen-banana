class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :title
      t.string :email
      t.string :company_address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :username
      t.string :password
      t.text :sp_product_service
      t.string :ar_first_name
      t.string :ar_last_name
      t.string :ar_email
      t.string :ar_phone_number
      t.string :ar_account_number
      t.string :phone_number
      t.boolean :active
      t.string :role
      t.text :dm_evaluating

      t.timestamps
    end
  end
end
