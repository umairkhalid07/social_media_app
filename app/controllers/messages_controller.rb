class MessagesController < ApplicationController
  def create
    @message = current_user.messages.new(message_params)
    if @message.save; head 200 else flash.now[:notice] => "Message Not Sent" end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy; head 200 else flash.now[:notice] => "Message Not Deleted" end
  end

  def message_params
    params.require(:message).permit(:user_id, :conversation_id, :body)
  end
end