class CommentsController < ApplicationController
  before_action :set_variables

  def create
    @comment = Comment.new(comment_params)
    @comment.save!
    redirect_to root_path
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :text)
  end

  def set_variables
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end
end
