class RenameTypeMeeting < ActiveRecord::Migration[5.1]
  def change
    rename_column :meetings, :type, :meeting_type
  end
end
