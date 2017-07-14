class ChangesToMeetings < ActiveRecord::Migration[5.1]
  def change
    change_column_default :meetings, :status, 'requested'
    add_column :meetings, :type, :string, default: 'in person'
    add_column :meetings, :instructions, :text
  end
end
