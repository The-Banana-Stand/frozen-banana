FactoryGirl.define do
  factory :question do

    association :user
    association :paid_inbox
    price_cents 300
    platform_fee_cents 100
    
  end
end
