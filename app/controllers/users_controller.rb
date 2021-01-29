class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
  end

  def show
  end
  
  private

  def find_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
  end
end
