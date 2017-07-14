class AddGaToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_reference(:meetings, :general_availability, index: true)
  end
end
