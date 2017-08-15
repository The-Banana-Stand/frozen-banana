require 'rails_helper'

RSpec.feature 'logging_in_with_linkedin' do

  scenario 'user logs in with linkedin successfully' do

    visit root_path

    set_omniauth

    find('#linkedin-login').click

    expect(page).to have_content 'Successfully authenticated from Linkedin account.'
  end

  context 'when linkedin profile is missing info' do
    scenario 'user is redirected to registration page' do
      visit root_path

      set_omniauth(email: nil)

      find('#linkedin-login').click

      expect(page).to have_content 'Registration'

      expect(page).to have_css '.alert-danger'
    end
  end



  context 'when linkedin fails' do
    scenario 'user sees flash message' do
      visit root_path

      set_invalid_omniauth

      find('#linkedin-login').click

      expect(page).to have_css('.alert-danger')
    end
  end


end