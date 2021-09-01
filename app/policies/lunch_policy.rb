class LunchPolicy < ApplicationPolicy
  attr_reader :user, :lunch

  def initialize(user, lunch)
    @user = user
    @lunch = lunch
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end