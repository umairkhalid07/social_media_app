class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save!

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Comment Posted" }
      format.turbo_stream { redirect_to root_path, flash.now[:notice] => "Comment Posted" }
    end
  end

  def edit
  end

  def update
    @comment.update(comment_params)

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Comment Updated" }
      format.turbo_stream { redirect_to root_path, flash.now[:notice] => "Comment Updated" }
    end
  end

  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Comment Deleted" }
      format.turbo_stream { redirect_to root_path, flash.now[:notice] => "Comment Deleted" }
    end
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
