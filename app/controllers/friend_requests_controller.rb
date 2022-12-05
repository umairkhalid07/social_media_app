class FriendRequestsController < ApplicationController

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    redirect_to friend_requests_path
  end

  def create_friend_request
    friend = User.find(params[:user_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      render root_path
    else
      redirect_to controller: :users, action: :index, notice: 'Cant send friend request'
    end
  end

  def accept_friend_request
    @friend_request = FriendRequest.find(params[:request_id])
    @friend_request.accept
    redirect_to friend_requests_path
  end
end
