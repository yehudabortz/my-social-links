require 'faker'

#users ---
#first name Faker::Name.first_name
#last name Faker::Name.last_name
#email Faker::Internet.email
#password Faker::Internet.password
#username Faker::Internet.username


#links ---
#url Faker::Internet.domain_name
#name Faker::Company.name

100.times do 
    @user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, username: Faker::Internet.username, email: Faker::Internet.email, password: Faker::Internet.password)
    @user.links << Link.create(name: Faker::Company.name, url: Faker::Internet.domain_name)
    @user.links << Link.create(name: Faker::Company.name, url: Faker::Internet.domain_name)
    @user.links << Link.create(name: Faker::Company.name, url: Faker::Internet.domain_name)
    @user.following_count = 0
    @user.followers_count = 0
    @user.save
end