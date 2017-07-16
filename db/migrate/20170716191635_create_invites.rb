class CreateInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :invites do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :company_name, null: false
      t.string :title
      t.string :company_address
      t.string :state
      t.string :zip_code
      t.string :phone_number
      t.string :email
      t.text :admin_comments
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
