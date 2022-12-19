class CommentsController < ApplicationController
  before_action :set_comment, :set_post, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save; head 200 else flash.now[:notice] => "Comment Not Created" end
  end

  def edit
  end

  def update
    if @comment.update(comment_params); head 200 else flash.now[:notice] => "Comment Not Updated" end
  end

  def destroy
    if @comment.destroy; head 200 else flash.now[:notice] => "Comment Not Destroyed" end
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
