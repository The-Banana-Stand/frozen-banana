require 'rails_helper'
require 'stripe_mock'


RSpec.feature 'sp creates a meeting', js: true do

  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:sp) {create(:user)}
  let(:dm) {create(:user_with_active_blocks)}
  after { StripeMock.stop }

  before(:each) do
    StripeMock.start
    sign_in sp
  end

  scenario 'sp schedules a meeting with a dm' do

    visit root_path

    click_on 'Schedule Time'

    click_on 'Find Meetings'

    fill_in 'q[full_name_or_company_name_or_city_or_state_or_zip_code_cont]', with: dm.first_name

    click_on 'Search'

    find('table tbody tr.accordion-toggle').click

    find("a[href='#{new_meeting_path(dm.active_blocks.first)}']").click

    click_on 'Submit Payment Information'

    pay_stripe

    expect(page).to have_content 'Confirmation'

  end

end