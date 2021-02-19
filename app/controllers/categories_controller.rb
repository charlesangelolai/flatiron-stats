class CategoriesController < ApplicationController
  include CategoriesHelper

  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :find_posts, only: [:show]
  before_action :redirect_if_not_admin, except: [:index, :show]
  
  def index
    @categories = Category.order(sort_column + " " + sort_direction)
  end

  def new
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category)
      flash[:success] = "Successfully created new category!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category)
      flash[:success] = "Successfully updated category!"
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
    flash[:success] = "Successfully deleted category."
  end

  private

  def find_posts
    @posts = @category.posts.order(sort_column + " " + sort_direction)
  end

  def find_category
    @category = Category.find_by_id(params[:id])
  end

  def redirect_if_not_admin
    unless is_admin?
      redirect_to categories_path
    end
  end

  def category_params
    params.require(:category).permit(
      :name,
      :description
    )
  end

  def sort_column
    Category.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
