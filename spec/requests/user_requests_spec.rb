require 'rails_helper'

RSpec.describe 'user requests' do

  describe 'account_setup' do
    it 'returns http status 200' do
      sign_in create(:user)

      get account_setup_path

      expect(response.status).to eq(200)

    end
  end

  describe 'resend-email' do
    it 'resends confirmation to user' do
      user = create(:user, confirmed_at: nil)
      count = ActionMailer::Base.deliveries.count
      get resend_email_path(user.id)

      expect(ActionMailer::Base.deliveries.count).to eq(count + 1)

    end
  end

end