FactoryGirl.define do
  factory :stream do
    title { Faker::Lorem.characters(10) }
    stream_key { SecureRandom.uuid }
    age_restriction { 0 }
    user
    channel { user.channel }
  end
end
