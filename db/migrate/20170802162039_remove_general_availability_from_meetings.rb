class RemoveGeneralAvailabilityFromMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :desired_day, :integer, default: 1
    add_column :meetings, :desired_start_time, :datetime
    add_column :meetings, :desired_end_time, :datetime

    Meeting.all.each do |meeting|
      desired_block = GeneralAvailability.find(meeting.general_availability_id)
      meeting.desired_day = desired_block.day
      meeting.desired_start_time = desired_block.start_time
      meeting.desired_end_time = desired_block.end_time
      meeting.save!
    end

    remove_reference :meetings, :general_availability
  end
end
