class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end


  def show?
    true
  end

  def create?
    true
  end

  def edit?
    record.user == user || user.admin
  end

  def update?
    record.user == user || user.admin
  end

  def destroy?
    record.user == user ||  user.admin
  end
end
