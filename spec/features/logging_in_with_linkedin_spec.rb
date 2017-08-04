require 'rails_helper'

RSpec.feature 'logging_in_with_linkedin' do

  scenario 'user logs in with linkedin successfully' do

    visit root_path

    set_omniauth

    find('a img').click

    expect(page).to have_content 'foobar@example.com'
  end


end