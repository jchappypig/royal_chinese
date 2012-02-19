FactoryGirl.define do
  factory :post do
    title Faker::Lorem.sentence
    content Faker::Lorem.sentences
    is_valid true
  end
end