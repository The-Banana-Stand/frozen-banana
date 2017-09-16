class AddBlockCloseToMeetingQueues < ActiveRecord::Migration[5.1]
  def change
    add_column :meeting_queues, :block_close_date, :datetime
    change_column_default :users, :price_cents, 10000
  end
end
