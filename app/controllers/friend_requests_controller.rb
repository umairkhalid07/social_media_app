class FriendRequestsController < ApplicationController
  def index
    @requests = FriendRequest.all
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
      redirect_to controller: :users, action: :index, notice: 'Sent friend request'
    else
      redirect_to controller: :users, action: :index, notice: 'Cant send friend request'
    end
  end

  def accept_friend_request
    @friend_request = FriendRequest.find(params[:request_id])
    @friend_request.accept
    redirect_to friends_path
  end
end
