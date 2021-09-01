class ScheduleLunchSerializer < ActiveModel::Serializer
  attributes :id, :week_of_year, :year, :day
  
  belongs_to :user
  belongs_to :lunch
end
