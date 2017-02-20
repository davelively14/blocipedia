class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update? && scope.where(:id => record.id).exists?
  end

  def destroy?
    if user.present? && scope.where(:id => record.id).exists?
      user.admin? || (record.user.id == user.id)
    else
      false
    end
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
