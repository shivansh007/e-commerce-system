FactoryGirl.define do
  factory :order do
    item nil
    user nil
    payment_mode 1
    payment_status 1
    order_status 1
  end
end
