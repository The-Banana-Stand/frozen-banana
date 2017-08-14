require 'rails_helper'

RSpec.feature 'logging_in_with_linkedin' do

  scenario 'user logs in with linkedin successfully' do

    visit root_path

    set_omniauth

    find('#linkedin-login').click

    expect(page).to have_content 'Successfully authenticated from Linkedin account.'
  end


end