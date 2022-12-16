class PostsController < ApplicationController
  before_action :set_posts, only: [:edit, :update, :destroy]
  def index
    @posts = Post.includes(:comments, :reactions)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create(post_params)
    @post.save

    respond_to do |format|
      if @post.persisted?
        format.html { redirect_to root_path, notice: "Post Created" }
        format.turbo_stream { redirect_to root_path, flash.now[:notice] => "Post Created" }
      else
        format.html { render :new, notice: "Post Not Created", status: :unprocessable_entity }
        format.turbo_stream { render :new, flash.now[:notice] => "Post Not Created", status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to root_path, notice: "Post Updated" }
        format.turbo_stream { redirect_to root_path, flash.now[:notice] => "Post Updated" }
      else
        format.html { render :edit, notice: "Post Not Updated", status: :unprocessable_entity }
        format.turbo_stream { render :edit, flash.now[:notice] => "Post Not Updated", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy ? head 200 : flash.now[:notice] => "Post Not Deleted"
  end

  private

  def post_params
    params.require(:post).permit(:text, :image)
  end

  def set_posts
    @post = current_user.posts.find(params[:id])
  end
end
