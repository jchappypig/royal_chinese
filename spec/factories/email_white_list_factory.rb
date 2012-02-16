FactoryGirl.define do
  factory :email_white_list do
    email Faker::Internet.email
  end
end