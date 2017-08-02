require 'rails_helper'

RSpec.feature 'user sends an invite' do

  let(:user) {create(:user)}

  context 'and they fill in all fields' do
    scenario 'they see a successful message' do
      sign_in user

      visit new_invite_path

      fill_in 'First Name', with: 'John'
      fill_in 'Last Name', with: 'Doe'
      fill_in 'Company Name', with: 'Doe LLC'

      click_on 'Send Invite'

      expect(page).to have_css '.alert-success'
    end
  end

  context 'and does not fill in required fields' do
    scenario 'they see a helpful error message' do
      sign_in user

      visit new_invite_path

      click_on 'Send Invite'

      expect(page).to have_css '.alert-danger'
      expect(page).to have_content 'Please review the problems below:'
    end
  end

end