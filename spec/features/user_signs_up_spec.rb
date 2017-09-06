require 'rails_helper'

RSpec.feature 'User signs up for site' do

  context 'user fills out form' do
    scenario 'user signs up successfully' do
      user = FactoryGirl.build_stubbed(:user)
      visit new_user_registration_path


      fill_in 'user[first_name]', with: user.first_name
      fill_in 'user[last_name]', with: user.last_name
      fill_in 'user[title]', with: user.title
      fill_in 'user[company_name]', with: user.company_name
      fill_in 'user[company_address]', with: user.company_address
      fill_in 'user[city]', with: user.city
      fill_in 'user[zip_code]', with: user.zip_code
      fill_in 'user[phone_number]', with: user.phone_number
      fill_in 'user[password]', with: 'foobar'
      fill_in 'user[password_confirmation]', with: 'foobar'
      select 'Nebraska', from: 'user[state]'
      fill_in 'user[email]', with: 'example@foobar.com'

      click_on 'Complete Registration'

      expect(page).to have_content 'Confirmation Email'

    end
  end

  context 'user does not fill out all fields' do
    scenario 'user sees errors' do
      visit new_user_registration_path

      click_on 'Complete Registration'

      expect(page).to have_css '.has-error'
    end
  end

  context 'after confirming email' do
    scenario 'user goes to account setup', js: true do
      user = create(:new_user)
      sign_in user
      visit account_setup_path

      click_on 'Decision Maker'

      # click_on 'Next'

      click_on 'Finish Setup'

      expect(page).to have_content('My Dashboard')

    end
  end

end