class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
  end

  def create
    params[:project][:user_id] = current_user.id
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      flash.now[:error] = @project.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      flash.now[:error] = @project.errors.full_messages
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def find_project
    @project = Project.find_by_id(params[:id])
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
end