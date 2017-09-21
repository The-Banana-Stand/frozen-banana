require 'rails_helper'

RSpec.describe Meeting, type: :model do

  describe '#create_confirmation_number' do
    it 'assigns a confirmation number on creation' do
      meeting = create(:meeting)
      expect(meeting.confirmation_number).to_not be_nil
    end
  end

  describe '#active' do
    it 'returns meetings with status of scheduled or requested' do
      create(:meeting, status: 'scheduled')
      create(:meeting, status: 'requested')
      create(:meeting, status: 'cancelled')
      expect(Meeting.active.count).to eq(2)
    end
  end



end
