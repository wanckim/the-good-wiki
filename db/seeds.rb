require 'faker'

# Create Users
User.create!(
  email: Faker::Internet.unique.email,
  password: Faker::Lorem.characters(10),
  role: "standard"
)

users = User.all

# Create Wikis
Wiki.create!(
  title: Faker::HarryPotter.character,
  body: Faker::HarryPotter.quote,
  private: Faker::Boolean.boolean,
  user: users.sample
)
