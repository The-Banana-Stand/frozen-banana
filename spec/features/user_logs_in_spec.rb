require 'rails_helper'

feature 'user logs in' do

  scenario 'user uses incorrect login info' do
    visit login_path

    fill_in 'Email', with: ''
    fill_in 'Password', with: ''

    click_button 'Log In'

    expect(page).to have_css '.alert-danger'

  end

  scenario 'user signs in correctly' do
    user = FactoryGirl.create(:user)

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log In'

    expect(page).to have_css '.alert-success'

  end

end