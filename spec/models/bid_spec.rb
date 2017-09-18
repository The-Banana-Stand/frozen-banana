require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe '#place_in_line' do
    it 'returns the integer position of a bids place in meeting queue' do
      queue = create(:meeting_queue)
      b1 = create(:bid, price_cents: 1000, meeting_queue: queue)
      b2 = create(:bid, price_cents: 3000, meeting_queue: queue)
      b3 = create(:bid, price_cents: 2000, meeting_queue: queue)
      b4 = create(:bid, price_cents: 500)

      expect(b1.place_in_line).to eq('1st')
      expect(b2.place_in_line).to eq('3rd')
      expect(b3.place_in_line).to eq('2nd')

    end
  end
end
