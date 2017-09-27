class Question < ApplicationRecord

  belongs_to :user
  belongs_to :paid_inbox

  monetize :price_cents, :platform_fee_cents
end
