require 'rails_helper'

RSpec.feature 'user logs in' do

  context 'user signs in correctly' do
    scenario 'user is logged in' do
      user = FactoryGirl.create(:user)

      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log In'

      expect(page).to have_content user.full_name
      expect(page.current_path).to eq(dashboard_path)
    end
  end


  context 'user uses incorrect login info' do
    scenario 'user sees an error message' do
      visit login_path

      fill_in 'Email', with: ''
      fill_in 'Password', with: ''

      click_button 'Log In'

      expect(page).to have_css '.alert-danger'
      expect(page).to have_content 'Invalid email/password combination'

    end
  end

end