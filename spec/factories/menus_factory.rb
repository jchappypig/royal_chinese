FactoryGirl.define do
  factory :menu do
    name {Faker::Name.name}
    category "Meat"
    price 1.5
    dish_type {Menu::DISH_TYPES.first}
  end
end