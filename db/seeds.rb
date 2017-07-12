# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
        first_name: 'Steven',
        last_name: 'Thiesfeld',
        username: 'StevenThiesfeld',
        email: 'scthiesfeld@gmail.com',
        company_name: 'The Banana Stand',
        title: 'CTO',
        company_address: '1009 Jones St.',
        city: 'Omaha',
        state: 'NE',
        zip_code: '68102',
        role: 'both',
        phone_number: '4024900248',
        password: 'password',
        activated: true,
        activated_at: Time.zone.now
)

User.create!(
    first_name: 'Kyle',
    last_name: 'Fowler',
    username: 'KyleFowler',
    email: 'kyleheinsonfowler@hotmail.com',
    company_name: 'The Banana Stand',
    title: 'CFO',
    company_address: '1009 Jones St.',
    city: 'Omaha',
    state: 'NE',
    zip_code: '68102',
    role: 'both',
    phone_number: '123456789',
    password: 'password',
    activated: true,
    activated_at: Time.zone.now
)

(1..50).each do |num|

  User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      username: Faker::DragonBall.unique.character,
      email: Faker::Internet.email,
      company_name: Faker::Company.name,
      title: Faker::Company.profession,
      company_address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zip_code: Faker::Address.zip,
      role: 'both',
      phone_number: Faker::PhoneNumber.cell_phone,
      password: 'password',
      activated: true,
      activated_at: Time.zone.now
  )

end