class AddAdminComments < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin_comments, :text
    add_column :meetings, :admin_comments, :text
    add_column :general_availabilities, :admin_comments, :text
    add_column :feedbacks, :admin_comments, :text
  end
end
