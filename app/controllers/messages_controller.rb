class MessagesController < ApplicationController
  def create
    @message = current_user.messages.new(message_params)
    @message.save ? head 200 : flash.now[:notice] => "Message Not Sent"
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy ? head 200 : flash.now[:notice] => "Message Not Deleted"
  end

  def message_params
    params.require(:message).permit(:user_id, :conversation_id, :body)
  end
end