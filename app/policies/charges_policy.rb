class ChargesPolicy < ApplicationPolicy
  def new?
    user.present? ? user.premium? : false
  end

  def create?
    user.present? ? user.premium? : false
  end

  def destroy?
    user.present? ? user.premium? : false
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
