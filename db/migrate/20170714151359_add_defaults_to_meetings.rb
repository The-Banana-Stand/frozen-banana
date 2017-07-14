class AddDefaultsToMeetings < ActiveRecord::Migration[5.1]
  def change
    change_column_default :meetings, :dm_calendar_status, 'pending'
    change_column_default :meetings, :sp_calendar_status, 'pending'
    change_column_default :meetings, :payment_status, 'pending'
    change_column_default :meetings, :status, 'pending'
  end
end
