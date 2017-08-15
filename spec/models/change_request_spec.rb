require 'rails_helper'

RSpec.describe ChangeRequest, type: :model do

  describe '#send_slack_notification' do
    it 'sends a message through slack notifier on creation' do
      request = build(:change_request)
      expect(SlackWrapper).to receive(:new_change_request_notification).with(request)
      #
      request.save!
    end
  end

end
