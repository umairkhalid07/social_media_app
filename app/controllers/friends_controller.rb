class FriendsController < ApplicationController
  def index
    @pagy, @friends = pagy(current_user.friends.includes(:conversations))
    @conversations = current_user.conversations
  end

  def destroy
    @friend = current_user.friends.find(params[:id])
    @conversation = find_conversation(current_user,  @friend)
    @conversation.destroy
    current_user.remove_friend(current_user, @friend)

    respond_to do |format|
      format.html { redirect_to friends_path, notice: "Friend Removed" }
      format.turbo_stream { redirect_to friends_path, flash.now[:notice] => "Friend Removed" }
    end
  end

  def find_conversation(user1, user2)
    conversation = Conversation.where(sender_id: user1.id, receiver_id: user2.id).or(Conversation.where(sender_id: user2.id, receiver_id: user1.id))
    conversation.first
  end
end
