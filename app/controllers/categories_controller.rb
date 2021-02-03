class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :find_posts, only: [:show]
  before_action :redirect_if_no_cohort
  
  def index
    @categories = Category.all
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
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categorys_path
  end

  private

  def find_posts
    @posts = @category.posts
  end

  def find_category
    @category = Category.find_by_id(params[:id])
  end

  def category_params
    params.require(:category).permit(
      :name,
      :description
    )
  end
end
