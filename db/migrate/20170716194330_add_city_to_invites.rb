class AddCityToInvites < ActiveRecord::Migration[5.1]
  def change
    add_column :invites, :city, :string
  end
end
