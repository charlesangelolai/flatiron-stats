class CohortsController < ApplicationController
  include CohortsHelper

  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  before_action :redirect_if_not_admin, only: [:edit, :update, :destroy]
  before_action :find_cohort, only: [:show, :edit, :update, :destroy]
  before_action :find_students, only: [:show]
  
  def index
    @cohorts = Cohort.order(sort_column + " " + sort_direction)
  end

  def new
    @cohort = Cohort.new
  end

  def show
  end

  def create
    if is_admin?
      @cohort = Cohort.new(cohort_admin_params)
    else
      @cohort = Cohort.new(cohort_student_params)
    end

    if @cohort.save
      redirect_to cohort_path(@cohort)
    else
      flash.now[:error] = @cohort.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if is_admin? && @cohort.update(cohort_admin_params)
      redirect_to cohort_path(@cohort)
    else
      flash.now[:error] = @cohort.errors.full_messages
      render :edit
    end
  end

  def destroy
    @cohort.destroy
    redirect_to cohorts_path
  end

  private

  def find_cohort
    @cohort = Cohort.find_by_id(params[:id])
    @students = @cohort.users
  end

  def find_students
    @students = @cohort.users
  end

  def redirect_if_not_admin
    unless is_admin?
      redirect_to cohorts_path
    end
  end

  def cohort_student_params
    params.require(:cohort).permit(
      :name,
      :program,
      :time
    )
  end

  def cohort_admin_params
    params.require(:cohort).permit(
      :name,
      :program,
      :time,
      :status
    )
  end

  def sort_column
    Cohort.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
