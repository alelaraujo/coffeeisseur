class PlacePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true  # Anyone can view a restaurant
  end

  def create?
    user.admin # Anyone can create a restaurant
  end

end
