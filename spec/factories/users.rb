FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password Faker::Internet.password
    phone Faker::PhoneNumber.cell_phone
    address Faker::Address.street_address
  end
end
