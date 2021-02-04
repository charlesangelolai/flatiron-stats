module ApplicationHelper
  def is_admin?
    current_user.role_id == 1
  end

  def is_instructor?
    current_user.role_id == 2
  end
end
