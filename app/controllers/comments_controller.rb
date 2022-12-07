class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save!
    redirect_to root_path
  end

  def edit
  end

  def update
    @comment.update(comment_params)
    redirect_to root_path
  end

  def destroy
    @comment.destroy!
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :text)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end
end
