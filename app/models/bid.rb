class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :meeting_queue
  has_paper_trail
  monetize :price_cents

  enum status: {active: 0, won: 1, cancelled: 2}

  def place_in_line
    if self.persisted? && self.active?
      Bid.where("price_cents <= ? AND meeting_queue_id = ? AND status = 0", self.price_cents, self.meeting_queue_id).count.ordinalize
    elsif self.cancelled?
      'Bid Cancelled'
    else
      'No Bid'
    end
  end
end
