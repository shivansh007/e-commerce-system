FactoryGirl.define do
  factory :order do
    item { Item.first || association(:item) }
    user { User.first || association(:user) }
    payment_mode Faker::Number.between(1, 4)
    payment_status Faker::Number.between(0, 1)
    order_status Faker::Number.between(1, 4)
  end
end
