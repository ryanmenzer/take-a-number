require 'faker'

User.delete_all
Appeal.delete_all
Gift.delete_all

# Create 5 users
acct_num_array = ["0550827", "0408646", "0550827", "0408646", "0550827"]
5.times.map do
  User.create first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: "password",
              account_number: acct_num_array.pop
end

# Create 10 appeals, two for each user
User.all.each do |user|
  2.times do
    Appeal.create user_id: user.id,
                  name: Faker::Commerce.product_name,
                  description: Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 5),
                  grid_size: rand(1..3)
  end
end

# Populate each appeal with gifts of varying amounts
Appeal.all.each do |appeal|
  amount = []
  amount.fill(0..99){|i| i+1}.shuffle!
  rand(25..75).times do

    Gift.create appeal_id: appeal.id,
                amount: amount.pop,
                donor: Faker::Name.name
  end
end