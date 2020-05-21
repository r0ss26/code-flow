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
                     first_name: Faker::Name.first_name,
                     middle_name: Faker::Name.middle_name,
                     last_name: Faker::Name.last_name,
                     city: Faker::Address.city,
                     country: Faker::Address.country,
                     biography: Faker::Lorem.paragraphs(number: 2).join("\n"))
  puts user.errors.any? ? user.errors.full_messages : "User #{i} created"
end

# Test User
user = User.create(email: "test@codeflow.com",
                   password: "123456",
                   first_name: "Test",
                   middle_name: "Andrew",
                   last_name: "Tester")

# Create employments for random users
for i in 0...100
  user = User.all.sample
  employment = user.employments.create(company: Faker::Company.name,
                          position: Faker::Company.profession,
                          start_date:Faker::Date.in_date_period(year: 2016),
                          end_date:Faker::Date.in_date_period(year: 2018))
  puts employment.errors.any? ? employmen.errors.full_messages : "Employment #{i} created"
end

# Create educations for random users
for i in 0...100
  user = User.all.sample
  education = user.educations.create(school: Faker::University.name,
                                     degree: Faker::Educator.course_name,
                                     start_date:Faker::Date.in_date_period(year: 2015),
                                     end_date:Faker::Date.in_date_period(year: 2018))
  puts education.errors.any? ? education.errors.full_messages : "Education #{i} created"
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
tags = []
for i in 0..50
  tags.push(Faker::Hacker.adjective)
end
for i in 0...100
  user = User.all.sample
  listing = user.listings.create(title: titles.sample,
                       category_id: rand(categories.length) + 1,
                       description: Faker::Lorem.paragraphs(number: 2).join("\n"),
                       price: (rand(5..50) + 1),
                       delivery_time: rand(1..7),
                       active: [true, false].sample,
                       tag_list: tags.sample(rand(1..8)))                
  puts listing.errors.any? ? listing.errors.full_messages : "Listing #{i} created"
end

# Create orders for random users
for i in 0..50
  listing = Listing.all.sample
  buyer_id = User.all.sample.id
  while buyer_id == listing.user_id
    buyer_id = User.all.sample.id
  end

  order = listing.orders.create(buyer_id: buyer_id,
                        seller_id: listing.user_id,
                        cost: listing.price,
                        paid: [true, false].sample,
                        completed: [true, false].sample)
  puts order.errors.any? ? order.errors.full_messages : "Order #{i} created"
end

# Create reviews
for i in 0..50
  order = Order.all.sample
  order.create_review(review_poster_id: order.buyer.id,
                      review_receiver_id: order.seller.id,
                      rating: rand(1..5),
                      description: Faker::Hipster.paragraph(sentence_count: rand(1..4))) unless order.review
  puts "Review #{i} created" 
  puts order.errors.full_messages if order.errors.any?

end

