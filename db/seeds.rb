# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  Person.destroy_all
  10.times do |n|
  Person.create!(first_name: "Stanislav#{n+1}", last_name: "Lapata", email_addresses_attributes: [{email: "LersSett@list.ru"}, {email: "Lers@list.ru"}, {email: "LersSett@gmail.com"}, {email: "LersSett@yandex.ru"}], phone_numbers_attributes: [phone_number: "+375(44)720-69-08"])
  end
