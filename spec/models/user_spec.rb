require 'rails_helper'
require 'support/omniauth_helper'

RSpec.describe User, type: :model do

  describe User, 'validations' do
    it {is_expected.to validate_presence_of(:first_name)}
    it {is_expected.to validate_presence_of(:last_name)}
    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_presence_of(:company_name)}
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    it {is_expected.to validate_uniqueness_of(:username)}
  end

  describe User, '#create_availabilities' do
    it 'creates associated records on creation' do
      user = FactoryGirl.create(:user)
      expect(user.general_availabilities.count).to eq(3)
    end

  end

  describe User, '#_create_queue' do
    it 'creates queue for user on creation' do
      user = create(:user)
      expect(user.meeting_queue).to be_a(MeetingQueue)
    end
  end

  describe User, '.from_omniauth' do
    it 'creates a user record from omniauth object' do
      set_omniauth

      user = User.from_omniauth(OmniAuth.config.mock_auth[:linkedin])

      expect(user.persisted?).to eq(true)
    end
  end

  describe User, '#full_address' do
    it 'returns a formatted address' do
      user = create(:user)
      expect(user.full_address).to be_a(String)
    end
  end

  describe User, '#price_for_meeting' do
    context 'given a meeting object' do
      it 'returns a price hash with correct amount' do
        user = create(:user)
        meeting = instance_double('Meeting', meeting_type: 'quick_pitch')
        expect(user.price_for_meeting(meeting)[:price]).to eq(Money.new(1700))

        expect(user.price_for_meeting[:price]).to eq(Money.new(10000))


      end
    end
  end


end
