class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :meeting_queue
  has_paper_trail
  monetize :price_cents

  enum status: {active: 0, won: 1, cancelled: 2}

  def place_in_line
    if self.persisted? && self.active?
      rank.ordinalize
    elsif self.cancelled?
      'Bid Cancelled'
    else
      'No Bid'
    end
  end

  def rank
    Bid.where("price_cents <= ? AND meeting_queue_id = ? AND status = 0", self.price_cents, self.meeting_queue_id).count
  end

  def wait_time
    if self.cancelled?
      return 'Bid Cancelled'
    elsif !self.persisted? || !self.active?
      return 'No Bid'
    end

    rank_unit = (rank / 2).ceil
    rank_unit -= 1 if rank.even?
    weeks = (rank_unit * time_available_unit).floor

    if weeks == 0
      'On Meeting Selection Date'
    elsif weeks == 1
      weeks.to_s + ' week from meeting selection'
    else
      weeks.to_s + ' weeks from meeting selection'
    end

  end

  def time_available_unit
    {
        '1 hour per Week': 1,
        '2 hours per Week': 0.5,
        '1 hour every 2 weeks': 2,
        '1 hour every 3 weeks': 3,
        '1 hour every 4 weeks': 4
    }.with_indifferent_access[self.meeting_queue.meeting_frequency]
  end

end
