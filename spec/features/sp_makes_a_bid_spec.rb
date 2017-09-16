require 'rails_helper'

RSpec.feature 'sp makes a bid', js: true do

  let(:sp) {create(:user, role: 'sp')}
  let(:dm) {create(:user_with_active_blocks)}

  before(:each){sign_in sp}

  scenario 'sp makes a new bid on a DMs time' do

    visit schedule_time_path

    fill_in 'q[full_name_or_company_name_or_city_or_state_or_zip_code_cont]', with: dm.first_name

    click_on 'Search'

    find('table tbody tr.accordion-toggle').click

    fill_in 'bid_price', with: '100'

    click_on 'Request Place Holder'

    expect(page).to have_content 'Bid Placed'

    expect(Bid.count).to eq(1)

  end

  context 'when a bid already exists' do
    context 'and rebidding is allowed' do
      scenario 'sp updates his bid' do
        create(:bid, meeting_queue_id: dm.meeting_queue.id, user_id: sp.id, can_rebid: true)

        visit schedule_time_path

        fill_in 'q[full_name_or_company_name_or_city_or_state_or_zip_code_cont]', with: dm.first_name

        click_on 'Search'

        find('table tbody tr.accordion-toggle').click

        fill_in 'bid_price', with: '100'

        click_on 'Update Bid'

        expect(page).to have_content 'Bid Updated'

      end
    end

    context 'and rebidding is not yet allowed' do
      scenario 'sp cannot update their bid' do
        create(:bid, meeting_queue_id: dm.meeting_queue.id, user_id: sp.id, can_rebid: false)

        visit schedule_time_path

        fill_in 'q[full_name_or_company_name_or_city_or_state_or_zip_code_cont]', with: dm.first_name

        click_on 'Search'

        find('table tbody tr.accordion-toggle').click

        expect(page).to have_button('Already Bid', disabled: true)

      end
    end
  end

end