class AddDefaultToInvite < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:invites, :company_name, '')

  end
end
