require 'rails_helper'

feature 'DM changes GA' do

  scenario 'DM goes to schedule time' do
    user = FactoryGirl.create(:user)
    log_in_as(user)

    visit schedule_time_path

    expect(page).to have_css('#decision_maker_tab')

  end

end