# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Users
for i in 0...50
  user = User.create(email: Faker::Internet.email,
                     password: Faker::Internet.password,
                     first_name: Faker::Book.author,
                     middle_name: Faker::Name.middle_name,
                     last_name: Faker::Name.last_name,
                     city: Faker::Address.city,
                     country: Faker::Address.country,
                     biography: Faker::Lorem.paragraphs(number: 2).join("\n"))
  puts "User #{i} created"
  puts user.errors.full_messages if user.errors.any?
end

# Create employments for random users
for i in 0...100
  user = User.all.sample
  user.employments.create(company: Faker::Company.name,
                          position: Faker::Company.profession,
                          start_date:Faker::Date.in_date_period(year: 2016),
                          end_date:Faker::Date.in_date_period(year: 2018))
  puts "Employment #{i} created"
end

# Create educations for random users
for i in 0...100
  user = User.all.sample
  user.educations.create(school: Faker::University.name,
                          degree: Faker::Educator.course_name,
                          start_date:Faker::Date.in_date_period(year: 2015),
                          end_date:Faker::Date.in_date_period(year: 2018))
  puts "Education #{i} created"
end

# Create the categories that a listing can have
categories = ["Code Review", "Video Tutoring", "Text Tutoring", "Phone Tutoring"]
categories.each do |category|
  Category.create(name: category)
  puts "Category #{category} created"
end

# Create listings for random users
titles = ["Javascript Help", 
         "Python Help", 
         "Java Help", 
         "I will review your code", 
         "I will review your Ruby code", 
         "I will be your code tutor"]

# Create listings for random users
for i in 0...100
  user = User.all.sample
  user.listings.create(title: titles.sample,
                       category_id: rand(categories.length) + 1,
                       description: Faker::Lorem.paragraphs(number: 2).join("\n"),
                       price: (rand(5..50) + 1) * 100,
                       delivery_time: rand(1..7),
                       active: [true, false].sample)
  puts "Listing #{i} created"
end
