class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  include ApplicationHelper 

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :cohort_id, cohort_attributes: [:name, :program, :time]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :cohort_id, cohort_attributes: [:name, :program, :time]], except: [:password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  private

  def redirect_if_not_logged_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def redirect_if_not_admin
    unless is_admin?
      redirect_to dashboard_path
    end
  end

  def redirect_if_not_admin_or_user
    unless @user == current_user
      redirect_to dashboard_path
    end
  end

  def redirect_if_no_cohort
    unless current_user.cohort_id
      redirect_to edit_user_registration_path
    end
  end
end