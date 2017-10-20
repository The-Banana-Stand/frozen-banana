require 'rails_helper'

RSpec.describe Bid, type: :model do

  describe '#place_in_line' do
    it 'returns the integer position of a bids place in meeting queue' do
      queue = create(:meeting_queue)
      b1 = create(:bid, price_cents: 1000, meeting_queue: queue)
      b2 = create(:bid, price_cents: 3000, meeting_queue: queue)
      b3 = create(:bid, price_cents: 2000, meeting_queue: queue)
      create(:bid, price_cents: 500)

      expect(b1.place_in_line).to eq('1st')
      expect(b2.place_in_line).to eq('3rd')
      expect(b3.place_in_line).to eq('2nd')

    end

    it 'returns no bid if not persisted' do
      bid = build(:bid)

      expect(bid.place_in_line).to eq('No Bid')
    end

    it 'returns cancelled if cancelled' do
      bid = create(:bid, status: :cancelled)

      expect(bid.place_in_line).to eq('Bid Cancelled')
    end
  end

  describe '#wait_time' do
    it 'returns the estimated wait time of a bid' do
      queue = create(:meeting_queue, meeting_frequency: 4)
      b1 = create(:bid, price_cents: 1000, meeting_queue: queue)
      b2 = create(:bid, price_cents: 2000, meeting_queue: queue)
      b3 = create(:bid, price_cents: 3000, meeting_queue: queue)
      b4 = create(:bid, price_cents: 4000, meeting_queue: queue)
      b5 = create(:bid, price_cents: 5000, meeting_queue: queue)

      expect(b1.wait_time).to eq('On Meeting Selection Date')
      expect(b2.wait_time).to eq('On Meeting Selection Date')
      expect(b3.wait_time).to eq('1 week from meeting selection')
      expect(b4.wait_time).to eq('1 week from meeting selection')
      expect(b5.wait_time).to eq('2 weeks from meeting selection')

    end

    it 'returns no bid if not persisted' do
      bid = build(:bid)

      expect(bid.wait_time).to eq('No Bid')
    end

    it 'returns cancelled if cancelled' do
      bid = create(:bid, status: :cancelled)

      expect(bid.wait_time).to eq('Bid Cancelled')
    end
  end
end
