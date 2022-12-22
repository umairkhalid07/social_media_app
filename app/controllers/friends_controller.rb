class FriendsController < ApplicationController
  def index
    if params[:search].present?
      @friends = current_user.friends.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
      @pagy = pagy(@friends)
    else
      @pagy, @friends = pagy(current_user.friends.includes(:conversations))
    end
    @conversations = current_user.conversations
  end

  def destroy
    @friend = current_user.friends.find(params[:id])

    respond_to do |format|
      if current_user.remove_friend(current_user, @friend)
        @conversation = find_conversation(current_user,  @friend)
        @conversation.destroy
        format.html { redirect_to friends_path, notice: "Friend removed" }
        format.turbo_stream { redirect_to friends_path, flash.now[:notice] => "Friend removed" }
      else
        format.html { redirect_to friends_path, notice: "Cant remove friend" }
        format.turbo_stream { redirect_to friends_path, flash.now[:notice] => "Cant remove friend" }
      end
    end
  end

  def find_conversation(user1, user2)
    conversation = Conversation.where(sender_id: user1.id, receiver_id: user2.id).or(Conversation.where(sender_id: user2.id, receiver_id: user1.id))
    conversation.first
  end
end
