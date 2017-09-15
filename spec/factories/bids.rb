FactoryGirl.define do
  factory :bid do
    association :meeting_queue
    association :user
    can_rebid false
    price_cents 10000
  end
end
