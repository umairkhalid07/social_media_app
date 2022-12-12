class ReactionsController < ApplicationController
  before_action :set_reaction

  # def like
  #   reaction = current_user.reactions.find_or_initialize_by(post_id: params[:post_id])
  #   if reaction.persisted?
  #     reaction.update(reaction_type: reaction.present? ? nil : params[:reaction_type])
  #   else
  #     reaction.update(reaction_type: params[:reaction_type])
  #   end
  #   redirect_to root_path
  # end

  def like
    if @reaction.blank?
      @reaction = current_user.reactions.create(post_id: params[:post_id], reaction_type: params[:reaction_type])
      @reaction.save
    elsif @reaction.reaction_type == true
      @reaction.update(reaction_type: nil)
    else
      @reaction.update(reaction_type: true)
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Post Liked" }
      format.turbo_stream { redirect_to root_path, flash.now[:notice] => "Post Liked" }
    end
  end

  def dislike
    if @reaction.blank?
      @reaction = current_user.reactions.create(post_id: params[:post_id], reaction_type: params[:reaction_type])
      @reaction.save!
    elsif @reaction.reaction_type == false
      @reaction.update(reaction_type: nil)
    else
      @reaction.update(reaction_type: false)
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Post Disliked" }
      format.turbo_stream { redirect_to root_path, flash.now[:notice] => "Post Disliked" }
    end
  end

  private

  def set_reaction
    @reaction = current_user.reactions.find_by(post_id: params[:post_id])
  end
end