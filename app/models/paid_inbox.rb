class PaidInbox < ApplicationRecord

  monetize :price_cents
  enum status: {active: 0, inactive: 1}
  enum delivery_frequency: {'Daily': 0, 'Every other day': 1, 'Weekly': 2, 'Every other week': 3}
  enum price_option: {'$3': 0, '$5': 1, '$10': 2, 'Let MeetingSlice Choose': 3}

  belongs_to :user
  has_many :questions, dependent: :destroy

  before_update :set_price


  private

  def set_price
    unless self.price_option =='Let MeetingSlice Choose'
      self.price = self.price_option
    end
  end

end
