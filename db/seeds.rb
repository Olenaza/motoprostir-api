# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
=begin
users = User.create([
                      { username: 'rider1',
                        firstName: 'Alex',
                        lastName: 'Poddybnuy',
                        email: 'example1@gmail.com',
                        gender: 'male',
                        password: '123456',
                        password_confirmation: '123456',
                        country: 'Ukraine',
                        city: 'Cherkasy'},
                      { username: 'rider2',
                        firstName: 'Max',
                        lastName: 'Zinchenko',
                        email: 'example2@gmail.com',
                        gender: 'male',
                        password: '789123',
                        password_confirmation: '789123',
                        country: 'Ukraine',
                        city: 'Cherkasy' },
                      { username: 'rider3',
                        firstName: 'Olena',
                        lastName: 'Zamkova',
                        email: 'example3@gmail.com',
                        gender: 'female',
                        password: '147915',
                        password_confirmation: '147915',
                        country: 'Ukraine',
                        city: 'Cherkasy' },
                      { username: 'rider4',
                        firstName: 'Eugene',
                        lastName: 'Voronyi',
                        email: 'example4@gmail.com',
                        gender: 'male',
                        password: '148345',
                        password_confirmation: '148345',
                        country: 'Ukraine',
                        city: 'Cherkasy' },
                    ])
=end
=begin
Event.create(
  title: 'Alex\'s first trip',
  type: 'enduro',
  ride_style: 'slow',
  speed: '60-90',
  start_date: Date.new(2019, 01, 01),
  end_date: Date.new.(2019, 01, 02),
  countries: ['Ukraine'],
  cities: ['Kyiv'],
  user: users.first)
Event.create(
  title: 'Alex\'s second trip',
  type: 'sport',
  ride_style: 'fast',
  speed: '80-120',
  start_date: Date.(2019, 02, 02),
  end_date: Date.new.(2019, 02, 03),
  countries: ['Ukraine'],
  cities: ['Korsun'],
  user: users.first)
Event.create(
    title: 'Max\'s first trip',
    type: 'enduro',
    ride_style: 'slow',
    speed: '60-90',
    start_date: Date.new(2019, 01, 01),
    end_date: Date.new.(2019, 01, 02),
    countries: ['Ukraine'],
    cities: ['Odesa'],
    user: users.second)
Event.create(
    title: 'Max\'s second trip',
    type: 'sport',
    ride_style: 'fast',
    speed: '80-120',
    start_date: Date.(2019, 02, 02),
    end_date: Date.new.(2019, 02, 03),
    countries: ['Ukraine'],
    cities: ['Obuhiv'],
    user: users.second)
=end
