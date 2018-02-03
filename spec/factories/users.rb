FactoryGirl.define do
  pw = Faker::Lorem.characters(10)

  factory :user do
    email Faker::Internet.unique.email
    password pw
    password_confirmation pw
    role "standard"
  end
end
