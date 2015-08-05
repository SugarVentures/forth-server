FactoryGirl.define do
  factory :channel do
    title { Faker::Lorem.characters(10) }
  end
end
