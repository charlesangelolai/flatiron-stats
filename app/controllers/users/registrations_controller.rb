# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :configure_account_update_params, only: [:edit, :update]
  
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    unless params[:user][:cohort_attributes].values.any?("")
      year = params[:user][:cohort_attributes]["name(1i)"]
      month = params[:user][:cohort_attributes]["name(2i)"]
      day = params[:user][:cohort_attributes]["name(3i)"]
      program = params[:user][:cohort_attributes][:program]
      time = params[:user][:cohort_attributes][:time]
  
      params[:user][:cohort_attributes].delete("name(1i)")
      params[:user][:cohort_attributes].delete("name(2i)")
      params[:user][:cohort_attributes].delete("name(3i)")
      
      full_date = format_date(year, month, day)
      params[:user][:cohort_attributes][:name] = format_cohort_name(full_date, program, time)
    end
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    year = params[:user][:cohort_attributes]["name(1i)"]
    month = params[:user][:cohort_attributes]["name(2i)"]
    day = params[:user][:cohort_attributes]["name(3i)"]
    program = params[:user][:cohort_attributes][:program]
    time = params[:user][:cohort_attributes][:time]

    params[:user][:cohort_attributes].delete("name(1i)")
    params[:user][:cohort_attributes].delete("name(2i)")
    params[:user][:cohort_attributes].delete("name(3i)")
    
    full_date = format_date(year, month, day)

    if full_date
      params[:user][:cohort_attributes][:name] = format_cohort_name(full_date, program, time)
    end
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def update_resource(resource, account_update_params)
    resource.update_without_password(account_update_params)
  end

  def after_update_path_for(resource)
    account_path(current_user)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, except: [:current_password, :password])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def format_date(year, month, day)
    unless [year, month, day].any?("")
      year = (year.to_i % 100).to_s
      month.prepend("0") unless month.length > 1
      day.prepend("0") unless day.length > 1
      full_date = month + day + year
      
      full_date
    end
  end

  def format_cohort_name(date, program, time)
    @COHORT_PROGRAMS = {
      "Software Engineering" => "seng",
      "Data Science" => "dsci",
      "Cyber Security" => "csec"
    }
    
    @COHORT_TIME = {
      "Full-Time" => "ft",
      "Part-Time" => "pt"
    }

    cohort_name = "#{@COHORT_PROGRAMS[program]}-#{@COHORT_TIME[time]}-#{date}"
    
    cohort_name
  end
end
