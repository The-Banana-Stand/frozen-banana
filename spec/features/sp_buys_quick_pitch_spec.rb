require 'rails_helper'
require 'stripe_mock'

RSpec.feature 'sp buys a quick pitch', js: true do

  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:sp) {create(:user, role: 'sp')}
  let(:dm) {create(:user_with_active_blocks)}
  after { StripeMock.stop }

  before(:each) do
    StripeMock.start
    sign_in sp
  end

  scenario 'sp buys a quick pitch with a dm' do

    visit root_path

    click_on 'Meeting Marketplace'

    fill_in 'q[full_name_or_company_name_or_city_or_state_or_zip_code_cont]', with: dm.first_name

    click_on 'Search'

    find('table tbody tr.accordion-toggle').click
    #
    # find("a[href='#{new_meeting_path(dm.active_blocks.first)}']").click

    within("#quick-pitch-container-#{dm.id}") do
      click_on 'Buy Now'
    end

    expect(page).to have_content '5 minutes'

    fill_in 'meeting[topic]', with: 'this is the topic'

    fill_stripe_elements

    find('input[name="commit"]').click

    expect(page).to have_content 'Confirmation'

  end

end