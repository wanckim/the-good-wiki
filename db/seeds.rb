require 'faker'

# Create Users
User.create!(
  email: "wckim88@gmail.com",
  password: "password",
  role: "admin"
)

User.create!(
  email: Faker::Internet.unique.email,
  password: Faker::Lorem.characters(10),
  role: "standard"
)

users = User.all

# Create Wikis
10.times do
  Wiki.create!(
    title: Faker::HarryPotter.character,
    body: Faker::HarryPotter.quote,
    private: Faker::Boolean.boolean,
    user: users.last
  )
end
