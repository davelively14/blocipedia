class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists? && is_authorized_to_view_private?(record)
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && is_authorized_to_view_private?(record)
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

  def is_authorized_to_view_private?(record)
    !record.private || user == record.user || record.collaborating_users.include?(user) || user.admin?
  end
end
