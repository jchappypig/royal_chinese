FactoryGirl.define do
  factory :menu do
    name Faker::Name
    category "Meat"
    price 1.5
    dish_type "Hotpot"
    is_vagetarian false
  end
end
