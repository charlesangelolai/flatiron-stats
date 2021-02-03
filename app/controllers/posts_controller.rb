class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_no_cohort
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @category = Category.find_by_id(params[:category_id])
  end
  
  def show
    @category = Category.find_by_id(params[:category_id])
    @comment = Comment.new
    @comments = @post.comments
  end

  def create
    @category = Category.find_by_id(params[:category_id])
    
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
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find_by_id(params[:id])
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
