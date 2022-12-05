class ReactionsController < ApplicationController
  before_action :set_variables
  def like
    if @reaction.blank?
      @reaction = Reaction.create(user: current_user, post: @post, reaction_type: params[:reaction_type])
      @reaction.save!
    elsif @reaction.reaction_type == true
      @reaction.update(reaction_type: nil)
    else
      @reaction.update(reaction_type: true)
    end
    redirect_to root_path
  end

  def dislike
    if @reaction.blank?
      @reaction = Reaction.create(user: current_user, post: @post, reaction_type: params[:reaction_type])
      @reaction.save!
    elsif @reaction.reaction_type == false
      @reaction.update(reaction_type: nil)
    else
      @reaction.update(reaction_type: false)
    end
    redirect_to root_path
  end

  private

  def set_variables
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @reaction = current_user.reactions.find_by(post_id: @post.id)
  end
end
