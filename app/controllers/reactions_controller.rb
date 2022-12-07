class ReactionsController < ApplicationController
  def like
    reaction = current_user.reactions.find_or_initialize_by(post_id: params[:post_id])
    if reaction.persisted?
      reaction.update(reaction_type: reaction.present? ? nil : params[:reaction_type])
    else
      reaction.update(reaction_type: params[:reaction_type])
    end
    redirect_to root_path
  end
  #
  # def dislike
  #   if @reaction.blank?
  #     @reaction = Reaction.create(user: current_user, post: @post, reaction_type: params[:reaction_type])
  #     @reaction.save!
  #   elsif @reaction.reaction_type == false
  #     @reaction.update(reaction_type: nil)
  #   else
  #     @reaction.update(reaction_type: false)
  #   end
  #   redirect_to root_path
  # end
end
