class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  before_action :redirect_if_not_admin, only: [:index, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end
  
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
    
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to dashboard_path
  end
  
  private

  def find_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :cohort_id,
      cohort_attributes: [
        :name,
        :program,
        :time
      ]
    )
  end

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
