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
    role 'dm'
    username 'JDoe'
    email 'johndoe@google.com'
    password 'foobar'
  end
end

