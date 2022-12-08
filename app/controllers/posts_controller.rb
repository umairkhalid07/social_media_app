class PostsController < ApplicationController
  before_action :set_posts, only: [:edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path }
        format.turbo_stream { redirect_to root_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to root_path }
        format.turbo_stream { redirect_to root_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy!
        format.html { redirect_to root_path }
        format.turbo_stream { redirect_to root_path }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:text, :image)
  end

  def set_posts
    @post = current_user.posts.find(params[:id])
  end
end
