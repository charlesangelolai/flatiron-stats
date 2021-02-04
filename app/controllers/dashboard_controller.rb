class DashboardController < ApplicationController
  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  
  def index
    @activities = PublicActivity::Activity.where.not(key: "user.update").order("created_at desc")
  end
end