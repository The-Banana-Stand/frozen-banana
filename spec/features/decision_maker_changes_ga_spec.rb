require 'rails_helper'

feature 'DM changes GA' do

  scenario 'user goes to schedule time' do
    user = FactoryGirl.create(:user)
    log_in_as(user)

    visit schedule_time_path

    expect(page).to have_css('#block_1')
  end

end