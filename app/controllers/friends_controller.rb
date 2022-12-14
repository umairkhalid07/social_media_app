class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def destroy
    @friend = current_user.friends.find(params[:id])
    current_user.remove_friend(current_user, @friend)
  end
end
