FactoryGirl.define do
  factory :item do
    name Faker::Commerce.product_name
    description Faker::Commerce.color
    price Faker::Commerce.price
    stock Faker::Number.between(1, 20)
    brand Faker::Commerce.material
    category { Category.first || association(:category) }
  end
end
