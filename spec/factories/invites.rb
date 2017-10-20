FactoryGirl.define do
  factory :invite do
    first_name 'John'
    last_name 'Doe'
    company_name 'Google'
    email Faker::Internet.email

    association :user
  end

end
