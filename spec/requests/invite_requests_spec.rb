require 'rails_helper'

RSpec.describe 'Invite Requests', type: :request do

  describe '#create' do
    it 'sends an email' do
      sign_in create(:user)

      count = ActionMailer::Base.deliveries.count

      post '/invites', params: {invite: {email: 'email@example.com', first_name: 'John', last_name: 'Doe'}}

      expect(response).to redirect_to new_invite_url
      expect(ActionMailer::Base.deliveries.count).to eq(count + 1)

    end

  end


end