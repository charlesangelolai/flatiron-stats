class SurveyResponsesController < ApplicationController
  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  before_action :find_response, only: [:show, :edit, :update, :destroy]
  before_action :find_project, :find_survey, only: [:new, :show, :create]
  before_action :find_survey_questions, only: [:new, :create]
  before_action :find_project_user, only: [:create]

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
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @survey_response.update(survey_response_params)
      redirect_to survey_response_path(@survey_response)
    else
      binding.pry
      render :edit
    end
  end

  def destroy
    @survey_response.destroy
    redirect_to surveys_response_path
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

  def survey_response_params
    params.require(:survey_response).permit(
      :design_response,
      :navigation_response,
      :error_handling_response,
      :rating_response,
      :project_id,
      :survey_id,
      :user_id
    )
  end
end
