class MeetingQueue < ApplicationRecord
  belongs_to :user
  has_many :bids

  monetize :minimum_bid_cents
  enum meeting_frequency: {'1 hour per Week': 0, '2 hours per Week': 1, '1 hour every 2 weeks': 2, '1 hour every 3 weeks': 3, '1 hour every 4 weeks': 4}
end