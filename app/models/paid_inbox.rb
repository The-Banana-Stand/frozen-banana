class PaidInbox < ApplicationRecord

  belongs_to :user
  has_many :questions, dependent: :destroy

  monetize :price_cents
end
