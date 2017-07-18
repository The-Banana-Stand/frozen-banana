class AddCommentsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :filter_comments, :text
    add_column :users, :validation_comments, :text
    add_column :users, :plat_validation_status, :string, default: 'new'
    add_column :meetings, :sp_requested_comments, :text


  end
end
