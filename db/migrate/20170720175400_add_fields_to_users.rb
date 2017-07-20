class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :dm_min_bottom_line_impact, :integer, default: 0, null: false
    add_column :users, :sp_small_bottom_line_impact, :integer, default: 0, null: false
    add_column :users, :sp_medium_bottom_line_impact, :integer, default: 0, null: false
    add_column :users, :sp_large_bottom_line_impact, :integer, default: 0, null: false
    add_column :users, :sp_small_impact_examples, :text
    add_column :users, :sp_medium_impact_examples, :text
    add_column :users, :sp_large_impact_examples, :text
    add_column :users, :sp_sales_cycle, :integer, default: 0, null: false
    add_column :users, :sp_close_percentage, :integer, default: 0, null: false
    add_column :users, :sp_organization_close_percentage, :integer, default: 0, null: false
  end
end
