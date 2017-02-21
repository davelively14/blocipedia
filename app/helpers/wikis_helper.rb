module WikisHelper
  def is_authorized_to_make_private?
    current_user.admin? || current_user.premium?
  end
end
