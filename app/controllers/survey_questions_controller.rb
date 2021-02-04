class SurveyQuestionsController < ApplicationController
  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  # before_action :find_survey_questions, only: [:show, :edit, :update, :destroy]

  # def index
  #   @survey_questions = SurveyQuestion.all
  # end

  # def new
  #   @survey_questions = SurveyQuestion.new
  # end

  # def show
  # end

  # def create
  #   @survey_questions = SurveyQuestion.new(survey_params)
  #   if @survey_questions.save
  #     redirect_to survey_path(@survey_questions)
  #   else
  #     flash.now[:error] = @survey_questions.errors.full_messages
  #     render :new
  #   end
  # end

  # def edit
  # end

  # def update
  #   if @survey_questions.update(survey_params)
  #     redirect_to survey_path(@survey_questions)
  #   else
  #     flash.now[:error] = @survey_question.errors.full_messages
  #     render :edit
  #   end
  # end

  # def destroy
  #   @survey_questions.destroy
  #   redirect_to survey_questions_path
  # end

  # private

  # def find_survey_questions
  #   @survey_questions = SurveyQuestion.find_by_id(params[:id])
  # end

  # def survey_params
  #   params.require(:survey_question).permit(
  #     :phase_num, 
  #     :design_question, 
  #     :navigation_question, 
  #     :error_handling_question, 
  #     :rating,
  #     survey_attributes: [:name]
  #   )
  # end
end
