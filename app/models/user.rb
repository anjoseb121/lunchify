# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :schedule_lunches
  has_many :lunches, through: :schedule_lunches

   enum role: {
    admin: 0,
    employee: 1
  }
end
