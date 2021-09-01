class ScheduleLunch < ApplicationRecord

  belongs_to :user
  belongs_to :lunch

  enum day: {
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5
  }
end
