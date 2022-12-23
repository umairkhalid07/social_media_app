class FriendRequestsController < ApplicationController
  def index
    @requests = FriendRequest.all
  end

  def create_friend_request
    friend = User.find(params[:user_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    respond_to do |format|
      if @friend_request.save
        format.html { redirect_to users_path, notice: "Sent friend request" }
        format.turbo_stream { redirect_to users_path, flash.now[:success] => "Sent friend request" }
      else
        format.html { redirect_to users_path, notice: "Cant send friend request" }
        format.turbo_stream { redirect_to users_path, flash.now[:error] => "Cant send friend request" }
      end
    end
  end

  def accept_friend_request
    @friend_request = FriendRequest.find(params[:request_id])

    respond_to do |format|
      if @friend_request.accept
        @conversation = Conversation.create(sender_id: params[:friend_id], receiver_id: current_user.id)
        format.html { redirect_to friends_path, notice: "Accepted friend request" }
        format.turbo_stream { redirect_to friends_path, flash.now[:success] => "Accepted friend request" }
      else
        format.html { redirect_to friends_path, notice: "Cant accept friend request" }
        format.turbo_stream { redirect_to friends_path, flash.now[:success] => "Cant accept friend request" }
      end
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])

    respond_to do |format|
      if @friend_request.destroy
        format.html { redirect_to friend_requests_path, notice: "Deleted friend request" }
        format.turbo_stream { redirect_to friend_requests_path, flash.now[:success] => "Deleted friend request" }
      else
        format.html { redirect_to friend_requests_path, notice: "Cant delete friend request" }
        format.turbo_stream { redirect_to friend_requests_path, flash.now[:error] => "Cant delete friend request" }
      end
    end
  end
end