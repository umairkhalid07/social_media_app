class PostsController < ApplicationController
  before_action :set_posts, only: [:edit, :update, :destroy]
  def index
    @pagy, @posts = pagy(Post.includes(:comments, :reactions), items: 5)
  end

  # def self.search(search)
  #   .search(params[:search])
  #   if search
  #     result = Post.find_by(content: search)
  #     if result
  #       self.where(post_id: result)
  #     else
  #       Post.all
  #     end
  #   else
  #     Post.all
  #   end
  # end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create(post_params)
    @post.save
    if @post.persisted?
      flash.now[:success] = "Post created !"
      redirect_to root_path
    else
      flash.now[:error] = "Post not created, please try again"
      render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash")
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash.now[:success] = "Post updated !"
      redirect_to root_path
    else
      flash.now[:error] = "Post not updated, please try again."
      render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash")
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
