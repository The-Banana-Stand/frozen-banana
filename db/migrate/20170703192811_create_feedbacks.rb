class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.text :dm_feedback
      t.text :sp_feedback
      t.text :admin_feedback
      t.integer :dm_id
      t.integer :sp_id
      t.belongs_to :meeting
      t.timestamps
    end
  end
end
