FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    password { 'long_password' }

    trait :admin do
      role { 0 }
    end
    trait :employee do
      role { 1 }
    end
  end
end
