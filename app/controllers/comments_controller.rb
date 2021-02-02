class CommentsController < ApplicationController
  def create
    @user = current_user
    @post = Post.find_by_id(params[:post_id])
    @category = Category.find_by_id(params[:category_id])

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
    if @comment.update(comment_params)
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_path
  end

  private

  def find_comment
    @comment = Comment.find_by_id(params[:id])
  end

  def comment_params
    params.require(:comment).permit(
      :content,
      :post_id,
      :user_id
    )
  end
end
