class StripeTransaction < ApplicationRecord

  belongs_to :meeting
  belongs_to :payer, class_name: 'User'
  belongs_to :payee, class_name: 'User'


end