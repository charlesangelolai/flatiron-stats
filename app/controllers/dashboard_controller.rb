class DashboardController < ApplicationController
  def index
    @activities = PublicActivity::Activity.where.not(key: "user.update").order("created_at desc")
  end
end