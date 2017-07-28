require 'rails_helper'

RSpec.feature 'user edits personal info' do

  before(:each) do
    @user = FactoryGirl.create(:user)

    sign_in @user
  end

  scenario 'user changes his password' do

    visit edit_user_registration_path

    click_on 'Email/Password'

    fill_in 'Password', with: 'new_password'

    fill_in 'Password confirmation', with: 'new_password'

    fill_in 'Current password', with: @user.password

    click_on 'Update'

    expect(page.current_path).to eq(edit_user_registration_path)
    expect(page).to have_css('.alert-success')

  end

  scenario 'user changes his name' do
    visit edit_user_registration_path

    click_on 'General'

    fill_in 'First Name', with: 'Newname'

    within('#general') do
      click_on 'Save Changes'
    end


    expect(page).to have_content('Newname')
    expect(page).to have_css('.alert-success')
  end

end