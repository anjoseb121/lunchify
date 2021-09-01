class Lunch < ApplicationRecord

  has_many :schedule_lunches
  has_many :lunches, through: :schedule_lunches

end
