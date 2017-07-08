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