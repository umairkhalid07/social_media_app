class CommentsController < ApplicationController
  before_action :set_comment, :set_post, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash.now[:success] = "Comment posted !"
      render turbo_stream: turbo_stream.prepend("flash", partial: "layouts/flash")
    else
      flash.now[:error] = "Comment not posted, please try again."
      render turbo_stream: turbo_stream.prepend("flash", partial: "layouts/flash")
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash.now[:success] = "Comment updated !"
      render turbo_stream: turbo_stream.prepend("flash", partial: "layouts/flash")
    else
      flash.now[:error] = "Comment not updated, please try again."
      render turbo_stream: turbo_stream.prepend("flash", partial: "layouts/flash")
    end
  end

  def destroy
    if @comment.destroy
      flash.now[:success] = "Comment deleted !"
      render turbo_stream: turbo_stream.prepend("flash", partial: "layouts/flash")
    else
      flash.now[:error] = "Comment not deleted, please try again."
      render turbo_stream: turbo_stream.prepend("flash", partial: "layouts/flash")
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
