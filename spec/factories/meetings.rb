FactoryGirl.define do
  factory :meeting do

    association :dm, factory: :user, strategy: :build
    association :sp, factory: :user, strategy: :build
    association :general_availability
    price_cents 10000
    platform_fee_cents { (10000 * 0.1621).round(0) }


  end
end