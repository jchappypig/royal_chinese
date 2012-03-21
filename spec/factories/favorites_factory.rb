FactoryGirl.define do
  factory :favorite do
    association :menu
    ip_address {Faker::Internet.ip_v4_address}
  end
end