namespace :users do

  desc 'creates dummy users for development environment'
  task :populate => :environment do

    unless User.all.empty?
      User.delete_all
      GeneralAvailability.delete_all
      Meeting.delete_all
    end

    50.times do

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
          activated_at: Time.zone.now,
          general_availabilities_attributes: [
              { block: 1, day: 1, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
              { block: 2, day: 2, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
              { block: 3, day: 3, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
              { block: 4, day: 4, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) },
              { block: 5, day: 5, start_time: Time.zone.now.midnight.change(hour: 9), end_time: Time.zone.now.midnight.change(hour: 17) }
          ]
      )

    end

  end

end