require 'rails_helper'

RSpec.describe Meeting, type: :model do

  describe '#create_confirmation_number' do
    it 'assigns a confirmation number on creation' do
      meeting = create(:meeting)
      expect(meeting.confirmation_number).to_not be_nil
    end
  end



end
