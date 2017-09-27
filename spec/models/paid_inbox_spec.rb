require 'rails_helper'

RSpec.describe PaidInbox, type: :model do

  describe '#set_price' do
    it 'sets price field before an update' do
      inbox = create(:paid_inbox)

      inbox.update(price_option: '$10')

      expect(inbox.price_cents).to eq(1000)
    end

    it 'does not change price if price option is let meetingslice choose' do
      inbox = create(:paid_inbox, price_cents: 700)

      inbox.update(price_option: 3)

      expect(inbox.price_cents).to eq(700)
    end
  end
end
