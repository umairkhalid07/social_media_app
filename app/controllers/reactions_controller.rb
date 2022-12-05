class ReactionsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @reaction = @post.reactions.new
    @reaction = @post.reactions.create(reaction_params)
    @reaction.save
    redirect_to root_path
  end

  private

  def reaction_params
    params.permit(:reaction_type)
  end
end
