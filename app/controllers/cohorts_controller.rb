class CohortsController < ApplicationController
  before_action :find_cohort, only: [:show, :edit, :update, :destroy]
  
  def index
    @cohorts = Cohort.all
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
end
