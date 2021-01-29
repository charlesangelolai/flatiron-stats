class SurveyResponsesController < ApplicationController
before_action :find_response, only: [:show, :edit, :update, :destroy]

  def index
    @survey_responses = SurveyResponse.all
  end

  def new
    @survey_response = SurveyResponse.new
    @project = Project.find_by_id(params[:project_id])
    @survey = Survey.find_by(phase_num: @project.phase_num)
    @survey_questions = SurveyQuestion.find_by_id(@survey.id)
  end

  def show
    
  end

  def create
    @survey_response = SurveyResponse.new(survey_params)
    if @survey_response.save
      redirect_to survey_response_path(@survey_response)
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

  def survey_response_params
    params.require(:survey_response).permit(
      :design_response,
      :navigation_response,
      :error_handling_response,
      :rating_response
    )
  end
end
