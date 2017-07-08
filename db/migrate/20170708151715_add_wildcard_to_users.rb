class AddWildcardToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :wildcard, :boolean, default: true
  end
end
