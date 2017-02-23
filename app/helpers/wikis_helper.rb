module WikisHelper
  def is_authorized_to_make_private?
    current_user.admin? || current_user.premium?
  end

  def is_authorized_to_view?(wiki)
    !wiki.private || current_user == wiki.user || wiki.collaborating_users.include?(current_user) || current_user.admin?
  end
end
