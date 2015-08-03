FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    faker_password = Faker::Internet.password
    password faker_password
    password_confirmation faker_password
    min_age { 21 }

    confirmed_at { Time.zone.now }
  end
end
