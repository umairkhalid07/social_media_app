class FriendRequestsController < ApplicationController
  def index
    @requests = FriendRequest.all
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    redirect_to friend_requests_path, notice: "Deleted Friend Request"
  end

  def create_friend_request
    friend = User.find(params[:user_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    respond_to do |format|
      if @friend_request.save
        format.html { redirect_to users_path, notice: "Sent Friend Request" }
        format.turbo_stream { redirect_to users_path, flash.now[:notice] => "Sent Friend Request" }
      else
        format.html { redirect_to friend_requests_path, notice: "Cant Send Friend Request" }
        format.turbo_stream { redirect_to friend_requests_path, flash.now[:notice] => "Cant Send Friend Request" }
      end
    end
  end

  def accept_friend_request
    @friend_request = FriendRequest.find(params[:request_id])
    @friend_request.accept
    @conversation = Conversation.create(sender_id: params[:friend_id], receiver_id: current_user.id)

    respond_to do |format|
      format.html { redirect_to friends_path, notice: "Accepted Friend Request" }
      format.turbo_stream { redirect_to friends_path, flash.now[:notice] => "Accepted Friend Request" }
    end
  end
end