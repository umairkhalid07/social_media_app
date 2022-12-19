class FriendsController < ApplicationController
  include ApplicationHelper
  def index
    @friends = current_user.friends.includes(:conversations)
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
end
