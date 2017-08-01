FactoryGirl.define do
  factory :user do
    first_name {Faker::Name.unique.first_name}
    last_name  'Doe'
    title 'CEO'
    company_name 'Google'
    company_address '123 Alphabet Lane'
    city 'Omaha'
    state 'NE'
    zip_code '68102'
    phone_number '4021234567'
    role 'both'
    username {first_name}
    email {Faker::Internet.unique.email}
    password 'foobar'
    confirmed_at Time.zone.now
    sign_in_count 1

    factory :new_user do
      sign_in_count 0
    end

    # user_with_posts will create post data after the user has been created
    factory :user_with_active_blocks do

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, evaluator|
        start_time = Time.zone.now
        end_time = Time.zone.now + 1.hour
        user.general_availabilities.each do |ga|
          ga.update_attributes(start_time: start_time, end_time: end_time)
        end
      end
    end

  end
end

