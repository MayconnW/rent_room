# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

development = true;

['admin'].each do |role|
  Role.find_or_create_by({name: role})
end

User.create({:email => "adm@adm.com", :name => 'admin', :url => "admin", :password => "a1s2d3f4", :password_confirmation => "a1s2d3f4", :role => Role.find_by_name('admin')})

if development 
  
  [1,2,3].each do |i|
    Hotel.create([:description => "Hotel #{i}", :address => "Test Street #{1}"])
  end
  
  [1,2,3].each do |i|
    hotels = Hotel.all
    hotels.each do |hotel|
      Apartment.create([:description => "Ap #{i}", :number => "60#{i}", :hotel => hotel])
    end
  end
  
  [1,2,3].each do |i| 
    apartments = Apartment.all
    apartments.each do |ap|
      Room.create([:description => "Room #{i}", :number => "#{i}", :apartment => ap, 
                    :price_month => 500*i, :price_secure => 250*i, :status => 1
      ])  
    end
  end
  
  10.times do |i|
    phone = rand(600..800).to_s + rand(600..800).to_s + rand(9999).to_s
    Client.create([:first_name => "Test#{i}", :last_name => "last#{i}", :phone => phone])  
  end
  
  
end