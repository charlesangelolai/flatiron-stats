class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  before_action :find_user, only: [:show]

  def show
  end
  
  private

  def find_user
    @user = User.find_by_id(params[:id])
  end
end
