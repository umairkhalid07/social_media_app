class PostsController < ApplicationController
  before_action :set_user
  def index
    @posts = Post.all
  end

  def new
    @post = @user.posts.new
  end

  def create
    @post = @user.posts.create(post_params)
    if @post.save!
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = @user.posts.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = @user.posts.find(params[:id])
    @post.destroy!
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:text, :image)
  end

  def set_user
    @user = current_user
  end
end
