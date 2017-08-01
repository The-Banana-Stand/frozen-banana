FactoryGirl.define do
  factory :general_availability do
    user
    day 1
    start_time {Time.zone.now}
    end_time {start_time + 1.hour}
  end
end