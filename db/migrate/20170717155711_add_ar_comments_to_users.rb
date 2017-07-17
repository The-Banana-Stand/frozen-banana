class AddArCommentsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ar_comments, :text
  end
end
