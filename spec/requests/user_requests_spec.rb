require 'rails_helper'

RSpec.describe 'user requests' do

  describe 'account_setup' do
    it 'returns http status 200' do
      sign_in create(:user)

      get account_setup_path

      expect(response.status).to eq(200)

    end
  end

end