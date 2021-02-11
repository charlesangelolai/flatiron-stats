class ProjectsController < ApplicationController
  include ProjectsHelper
  helper_method :sort_direction, :sort_direction
  
  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_project_not_found, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_admin_or_owner, only: [:edit, :update, :destroy]

  def index
    @projects = Project.order(sort_column + " " + sort_direction)
  end

  def new
    @project = Project.new
  end

  def show
    project_report
  end

  def create
    params[:project][:user_id] = current_user.id
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project)
      flash[:success] = "Successfully created new project!"
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @project.update(project_params)
      redirect_to project_path(@project)
      flash[:success] = "Successfully updated project!"
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
    flash[:success] = "Successfully deleted project."
  end

  private

  def find_project
    @project = Project.find_by_id(params[:id])
  end

  def redirect_if_project_not_found
    unless @project
      redirect_to projects_path
    end
  end

  def redirect_if_not_admin_or_owner
    unless @project.user == current_user
      redirect_to project_path(@project)
    end
  end

  def project_report
    @survey_count = @project.survey_responses.count
    @design_score = @project.survey_responses.calculate(:average, :design_response).to_f.round(2)
    @navigation_score = @project.survey_responses.calculate(:average, :navigation_response).to_f.round(2)
    @error_handling_score = @project.survey_responses.calculate(:average, :error_handling_response).to_f.round(2)
    @rating_score = ((@design_score + @navigation_score + @error_handling_score)/3.00).round(2)
  end

  def project_params
    params.require(:project).permit(
      :name,
      :phase_num,
      :description,
      :website_link,
      :github_link,
      :blog_link,
      :video_link,
      :user_id
    )
  end

  def sort_column
    Project.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
end