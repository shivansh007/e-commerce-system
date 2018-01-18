FactoryGirl.define do
  factory :invoice do
    order { Order.first || association(:order) }
  end
end
