class CreateQuestions < ActiveRecord::Migration[5.1]
  def up
    create_table :questions do |t|
      t.belongs_to :user
      t.belongs_to :paid_inbox
      t.string :question, default: ''
      t.string :answer, default: ''
      t.boolean :confidential, default: false
      t.integer :price_cents, null: false
      t.string :price_currency, default: "USD", null: false
      t.integer :platform_fee_cents, null: false
      t.string :platform_fee_currency, default: "USD", null: false

      t.timestamps
    end
  end

  def down
    drop_table :questions
  end
end
