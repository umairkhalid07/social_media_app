class ReactionsController < ApplicationController
  def like
    reaction = current_user.reactions.find_or_initialize_by(post_id: params[:post_id])
    @post = reaction.post
    if reaction.persisted?
      reaction.update(reaction_type: reaction.reaction_type.to_s == params[:reaction_type] ? nil : params[:reaction_type])
    else
      reaction.update(reaction_type: params[:reaction_type])
    end
  end
end