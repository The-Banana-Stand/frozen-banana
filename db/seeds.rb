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
    activated_at: Time.zone.now,
    admin: true,
    general_availabilities_attributes: [
        { block: 1, day: 1, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 2, day: 2, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 3, day: 3, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 4, day: 4, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 5, day: 5, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) }
    ]
)

User.create!(
    first_name: 'Kyle',
    last_name: 'Fowler',
    username: 'KyleFowler',
    email: 'kyleheinsonfowler@hotmail.com',
    company_name: 'MeetingSlice',
    title: 'CEO',
    company_address: '1207 Leavenworth St.',
    city: 'Omaha',
    state: 'NE',
    zip_code: '68102',
    role: 'both',
    phone_number: '4029602347',
    password: 'password',
    activated: true,
    activated_at: Time.zone.now,
    admin: true,
    general_availabilities_attributes: [
        { block: 1, day: 1, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 2, day: 2, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 3, day: 3, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 4, day: 4, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 5, day: 5, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) }
    ]
)

User.create!(
    first_name: 'Nolan',
    last_name: 'Allen',
    username: 'NolanAllen',
    email: 'nolan.louis.allen@gmail.com',
    company_name: 'MeetingSlice',
    title: 'CEO',
    company_address: '1207 Leavenworth Street',
    city: 'Omaha',
    state: 'NE',
    zip_code: '68102',
    role: 'both',
    phone_number: '2066597652',
    password: 'qb57613',
    activated: true,
    activated_at: Time.zone.now,
    admin: true,
    general_availabilities_attributes: [
        { block: 1, day: 1, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 2, day: 2, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 3, day: 3, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 4, day: 4, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
        { block: 5, day: 5, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) }
    ]
)