class SurveyResponsesController < ApplicationController
  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  before_action :find_project, :find_survey, only: [:new, :show, :create]
  before_action :redirect_if_owner, :find_survey_questions, only: [:new, :create]
  before_action :response_exist?, :find_project_user, only: [:create]
  before_action :find_response, only: [:show]

  def index
    @survey_responses = SurveyResponse.all
  end

  def new
    @survey_response = SurveyResponse.new
  end

  def show
  end

  def create
    params[:survey_response][:project_id] = @project.id
    params[:survey_response][:survey_id] = @survey.id
    params[:survey_response][:user_id] = @project_user.id
    
    @survey_response = SurveyResponse.new(survey_response_params)

    if @survey_response.save
      redirect_to project_path(@project)
      flash[:success] = "Thanks for submitting a survey!"
    else
      render :new
    end
  end

  private

  def find_survey_response
    @survey_response = SurveyResponse.find_by_id(params[:id])
  end

  def find_project
    @project = Project.find_by_id(params[:project_id])
  end

  def find_survey
    @survey = Survey.find_by(phase_num: @project.phase_num)
  end

  def find_survey_questions
    @survey_questions = SurveyQuestion.find_by_id(@survey.id)
  end

  def find_project_user
    @project_user = @project.user
  end
  
  def response_exist?
    unless params[:survey_response]
      redirect_to new_project_survey_responses_path(@project)
      flash[:error] = "Error submitting survey. Please fill-in every section."
    end
  end

  def redirect_if_owner
    if @project.user == current_user
      redirect_to project_path(@project)
    end
  end

  def survey_response_params
    params.require(:survey_response).permit(
      :design_response,
      :navigation_response,
      :error_handling_response,
      :project_id,
      :survey_id,
      :user_id
    )
  end
end
