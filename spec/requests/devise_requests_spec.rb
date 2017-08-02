require 'rails_helper'

RSpec.describe 'devise requests', type: :request do
  context 'on first login' do
    it 'redirects to account setup path' do
      new_user = FactoryGirl.create(:new_user)

      post user_session_path, params: {user: {email: new_user.email, password: new_user.password} }

      expect(response).to redirect_to account_setup_url
    end
  end

  context 'on subsequent logins' do
    it 'redirects to root path' do
      user = FactoryGirl.create(:user, sign_in_count: 1)

      post user_session_path, params: {user: {email: user.email, password: user.password} }

      expect(response).to redirect_to root_url
    end
  end

end