class MeetingQueue < ApplicationRecord
  belongs_to :user
  has_many :bids
  has_paper_trail

  monetize :minimum_bid_cents
  enum meeting_frequency: {'1 hour per Week': 0, '2 hours per Week': 1, '1 hour every 2 weeks': 2, '1 hour every 3 weeks': 3, '1 hour every 4 weeks': 4}

  before_create :set_defaults

  def show_block_close_date
    self.block_close_date.strftime('%m/%d/%Y at %I:%M%p')
  end

  private

  def set_defaults
    self.block_close_date = Time.zone.now.end_of_week.beginning_of_day + 20.hours
    self.last_scheduled_at = Time.now
  end



end