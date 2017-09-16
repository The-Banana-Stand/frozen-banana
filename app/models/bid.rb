class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :meeting_queue
  has_paper_trail
  monetize :price_cents

  enum status: {active: 0, won: 1, cancelled: 2}
end
