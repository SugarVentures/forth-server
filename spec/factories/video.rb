FactoryGirl.define do
  factory :video do
    title { Faker::Lorem.characters(10) }
    stream
  end
end
