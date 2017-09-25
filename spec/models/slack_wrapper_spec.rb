require 'rails_helper'

RSpec.describe SlackWrapper, type: :model do

  describe '.change_request_notification' do
    it 'sends a ping to SLACK' do
      change_request = build_stubbed(:change_request)
      expect(subject).to receive(:send_to_slack)
      subject.new_change_request_notification(change_request)
    end
  end

  describe '.confirmation_help_request' do
    it 'sends a ping to SLACK' do
      user = build_stubbed(:user)
      expect(subject).to receive(:send_to_slack)
      subject.confirmation_help_request(user, '1234567788')
    end
  end

  describe '.new_user_notification' do
    it 'sends a ping to SLACK' do
      user = build_stubbed(:user)
      expect(subject).to receive(:send_to_slack)
      subject.new_user_notification(user)
    end
  end

  describe '.new_meeting_notification' do
    it 'sends a ping to SLACK' do
      meeting = build_stubbed(:meeting)
      expect(subject).to receive(:send_to_slack)
      subject.new_meeting_notification(meeting)
    end
  end

  describe '.new_bid_notification' do
    it 'sends a ping to SLACK' do
      bid = build_stubbed(:bid)
      expect(subject).to receive(:send_to_slack)
      subject.new_bid_notification(bid)
    end
  end

end