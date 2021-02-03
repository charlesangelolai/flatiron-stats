module ApplicationHelper
  def is_admin?
    current_user.role_id == 1
  end

  def is_instructor?
    current_user.role_id == 2
  end

  def redirect_if_no_cohort
    unless current_user.cohort_id
      redirect_to edit_user_registration_path
    end
  end
end
