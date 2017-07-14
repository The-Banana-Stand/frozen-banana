class CreateChangeRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :change_requests do |t|
      t.text :request, null: false
      t.text :admin_comment
      t.belongs_to :user, index: true
      t.belongs_to :meeting, index: true

      t.timestamps
    end
  end
end
