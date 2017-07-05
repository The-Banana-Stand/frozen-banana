require 'rails_helper'

feature 'User signs up for site' do

  scenario 'user goes to sign up page from homepage' do
    visit root_path

    click_on 'Register Now!'

    expect(current_path).to eq(signup_path)
  end

end