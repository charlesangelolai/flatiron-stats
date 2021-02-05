class PostsController < ApplicationController
  include PostsHelper

  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  before_action :find_category, only: [:new, :show, :create, :edit, :update, :destroy]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :find_comments, only: [:show, :edit, :update]
  before_action :redirect_if_not_admin_or_owner, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end
  
  def show
    @comment = Comment.new
  end

  def create
    params[:post][:category_id] = @category.id
    params[:post][:user_id] = current_user.id
    
    @post = Post.new(post_params)
    if @post.save
      redirect_to category_post_path(@category, @post)
    else
      binding.pry
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to category_post_path(@category, @post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to category_path(@category)
  end

  private

  def find_post
    @post = Post.find_by_id(params[:id])
  end

  def find_category
    @category = Category.find_by_id(params[:category_id])
  end

  def find_comments
    @comments = @post.comments
  end

  def redirect_if_not_admin_or_owner
    unless is_admin? || @post.user == current_user
      redirect_to category_post_path(@post)
    end
  end

  def post_params
    params.require(:post).permit(
      :title,
      :content,
      :category_id,
      :user_id
    )
  end
end
