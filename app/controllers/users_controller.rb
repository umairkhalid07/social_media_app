class UsersController < ApplicationController
  def index
    if params[:search].present?
      @users = User.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
      @pagy = pagy(@users)
    else
      @pagy, @users = pagy(User.all)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:post).permit(:search)
  end
end
