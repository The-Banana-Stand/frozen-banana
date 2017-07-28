FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
    title 'CEO'
    company_name 'Google'
    company_address '123 Alphabet Lane'
    city 'Omaha'
    state 'NE'
    zip_code '68102'
    phone_number '4021234567'
    role 'both'
    username {Faker::Name.unique.first_name}
    email {Faker::Internet.unique.email}
    password 'foobar'
    confirmed_at Time.zone.now
    sign_in_count 1

    factory :new_user do
      sign_in_count 0
    end

  end
end

