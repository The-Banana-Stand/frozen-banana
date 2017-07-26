class AddPlatformFeeToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :platform_fee_cents, :integer
  end
end
