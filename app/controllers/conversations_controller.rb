class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    @friend = @conversation.sender_id == current_user.id ? User.find(@conversation.receiver_id) : User.find(@conversation.sender_id)
  end
end
