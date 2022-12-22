class PostsController < ApplicationController
  before_action :set_posts, only: [:edit, :update, :destroy]
  def index
    # if params[:search].present?
    #   @posts = Post.where()
    #   @pagy = pagy(Post.includes(:comments, :reactions))
    # else
    #   @pagy, @posts = pagy(Post.includes(:comments, :reactions))
    # end
    @pagy, @posts = pagy(Post.includes(:comments, :reactions))
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create(post_params)
    @post.save

    respond_to do |format|
      if @post.persisted?
        format.html { redirect_to root_path, notice: "Post created !" }
        format.turbo_stream { redirect_to root_path, flash.now[:success] => "Post created !" }
      else
        format.html {
          flash.now[:error] = "Post not created, please try again"
          render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash")
        }
        format.turbo_stream {
          flash.now[:error] = "Post not created, please try again"
          render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash")
        }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to root_path, notice: "Post updated !" }
        format.turbo_stream { redirect_to root_path, flash.now[:success] => "Post updated !" }
      else
        format.html {
          flash.now[:error] = "Post not updated, please try again."
          render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash")
        }
        format.turbo_stream {
          flash.now[:error] = "Post not updated, please try again."
          render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash")
        }
      end
    end
  end

  def destroy
    if @post.destroy
      flash.now[:success] = "Post deleted !"
      render turbo_stream: turbo_stream.prepend("flash", partial: "layouts/flash")
    else
      flash.now[:error] = "Post not deleted, please try again."
      render turbo_stream: turbo_stream.prepend("flash", partial: "layouts/flash")
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :search)
  end

  def set_posts
    @post = current_user.posts.find(params[:id])
  end
end
