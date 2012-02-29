FactoryGirl.define do
  factory :follower do
    name Faker::Name.name
    email Faker::Internet.email
    is_subscribe true
  end
end