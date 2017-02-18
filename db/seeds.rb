# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['admin'].each do |role|
  Role.find_or_create_by({name: role})
end

User.create({:email => "adm@adm.com", :url => "admin", :password => "a1s2d3f4", :password_confirmation => "a1s2d3f4", :role => Role.find_by_name('admin')})

Hotel.create([:description => "Hotel 1", :address => "Test Street"])

Apartment.create([:description => "Ap 1", :number => "322", :hotel => Hotel.first])

Room.create([:description => "Room 1", :number => "1", :apartment => Apartment.first, :price_month => 500, :price_secure => 250])

Client.create([:first_name => "Test1", :last_name => "Test2", :phone => "9993332222"])