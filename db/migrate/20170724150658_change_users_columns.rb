class ChangeUsersColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :sp_small_bottom_line_impact, :sp_small_revenue
    rename_column :users, :sp_medium_bottom_line_impact, :sp_medium_revenue
    rename_column :users, :sp_large_bottom_line_impact, :sp_large_revenue

    rename_column :users, :sp_small_impact_examples, :sp_small_revenue_examples
    rename_column :users, :sp_medium_impact_examples, :sp_medium_revenue_examples
    rename_column :users, :sp_large_impact_examples, :sp_large_revenue_examples
  end
end
