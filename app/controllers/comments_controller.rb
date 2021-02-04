class CommentsController < ApplicationController
  before_action :redirect_if_not_logged_in, :redirect_if_no_cohort
  before_action :find_category, :find_post, :find_comments, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]
  
  def create
    @user = current_user

    params[:comment][:post_id] = @post.id
    params[:comment][:user_id] = @user.id

    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to category_post_path(@category, @post)
    else
      binding.pry
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_update_params)
      redirect_to category_post_path(@category, @post)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to category_post_path(@category, @post)
  end

  private

  def find_comment
    @comment = Comment.find_by_id(params[:id])
  end

  def find_post
    @post = Post.find_by_id(params[:post_id])
  end

  def find_category
    @category = Category.find_by_id(params[:category_id])
  end

  def find_comments
    @comments = @post.comments
  end

  def comment_params
    params.require(:comment).permit(
      :content,
      :post_id,
      :user_id
    )
  end

  def comment_update_params
    params.require(:comment).permit(:content)
  end
end
