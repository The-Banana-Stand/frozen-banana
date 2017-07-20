class AddConfirmationNumToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :confirmation_number, :string
  end
end
