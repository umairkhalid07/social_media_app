class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])

    if @conversation.sender_id == current_user.id
      @friend = User.find(@conversation.receiver_id)
    else
      @friend = User.find(@conversation.sender_id)
    end
  end
end
