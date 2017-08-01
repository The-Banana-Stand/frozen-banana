require 'rails_helper'

RSpec.feature 'user views his dashboard' do

  let(:meeting) {create(:meeting)}



  scenario 'and sees their scheduled meetings' do

    sign_in meeting.dm

    visit root_path

    expect(page).to have_content 'Requested'

  end

  scenario 'and makes a change request' do

    sign_in meeting.dm

    visit root_path

    click_on 'Change'

    fill_in 'Request', with: 'Change'

    click_on 'Create Change Request'

    expect(page).to have_content 'Change pending'

  end

end