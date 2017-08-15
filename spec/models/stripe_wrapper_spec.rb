require 'rails_helper'
require 'stripe_mock'

RSpec.describe StripeWrapper, type: :model do

  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:user){create(:user)}

  before(:each){StripeMock.start}
  after(:each){StripeMock.stop}

  describe '#process_payment_info' do
    it 'saves source to Stripe::Customer' do

      results = user.process_payment_info(stripe_helper.generate_card_token)

      expect(results).to eq(user.stripe_customer)

    end
  end

  describe '#create_stripe_customer' do
    it 'creates a new Stripe::Customer with user info' do

      customer = user.create_stripe_customer

      expect(user.customer_token).to eq(customer.id)
    end
  end

  describe '#fetch_stripe_customer' do
    context 'when stripe_customer exists' do
      it 'returns stripe customer' do

        user.create_stripe_customer

        customer = user.fetch_stripe_customer

        expect(user.customer_token).to eq customer.id
      end
    end

    context 'when stripe customer has been deleted' do
      it 'creates a new stripe customer' do

        user.create_stripe_customer

        user.stripe_customer.delete

        expect(user).to receive(:create_stripe_customer)

        user.fetch_stripe_customer
      end
    end

    context 'when no stripe customer exists for user' do
      it 'creates a new stripe customer' do
        expect(user).to receive(:create_stripe_customer)

        user.fetch_stripe_customer
      end
    end
  end

end