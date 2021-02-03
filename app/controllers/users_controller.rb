class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :redirect_if_no_cohort

  def show
  end
  
  private

  def find_user
    @user = User.find_by_id(params[:id])
  end
end
