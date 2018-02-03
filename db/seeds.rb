require 'faker'

# Create Users
User.create!(
  email: "wckim88@gmail.com",
  password: "password",
  role: "admin"
)

# User.create!(
#   email: Faker::Internet.unique.email,
#   password: Faker::Lorem.characters(10),
#   role: "standard"
# )

User.create!(
  email: "user@bloccit.com",
  password: "password",
  role: "premium"
)

User.create!(
  email: "new_user@bloccit.com",
  password: "password",
  role: "premium"
)

users = User.all

# Create Wikis
50.times do
  Wiki.create!(
    title: Faker::HarryPotter.character,
    body: Faker::HarryPotter.quote,
    private: true,
    user: users.sample
  )
end
