FactoryGirl.define do
  factory :meeting do

    status 'requested'
    association :dm, factory: :user
    association :sp, factory: :user
    price_cents 10000
    platform_fee_cents { (10000 * 0.1621).round(0) }
    desired_start_time {Time.zone.now}
    desired_end_time {desired_start_time + 1.hour}
    topic 'this is the topic of the meeting'


  end
end