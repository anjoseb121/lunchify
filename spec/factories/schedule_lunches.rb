FactoryBot.define do
  factory :schedule_lunch do
    day { 'monday' }
    week_of_year { 30 }

    association :user
    association :lunch
  end
end
