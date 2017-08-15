require 'rails_helper'
require 'stripe_mock'

RSpec.feature 'admin custom features' do

  let(:admin) {create(:admin)}
  let(:stripe_helper) { StripeMock.create_test_helper }

  context 'admin impersonates a user' do
    scenario 'admin is logged in as that user' do

      user = create(:user)

      sign_in admin

      visit "admin/user/#{user.id}/impersonate"

      expect(page).to have_content user.full_name
      expect(page).to have_content 'My Dashboard'
    end
  end

  context 'admin process a payment' do
    scenario 'they see a success message' do
      sign_in admin

      StripeMock.start

      meeting = create(:meeting)
      customer = Stripe::Customer.create({
                                  email: 'johnny@appleseed.com',
                                  source: stripe_helper.generate_card_token
                              })
      meeting.sp.update_attribute(:customer_token, customer.id)

      visit "/admin/meeting/#{meeting.id}/payment_capture"

      expect(page).to have_content 'Payment Status: succeeded'
      StripeMock.stop
    end

  end

end