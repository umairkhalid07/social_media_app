class MessagesController < ApplicationController
  def create
    @message = current_user.messages.new(message_params)
    if @message.save; head 200 else flash.now[:notice] = "Message n sent" end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy; head 200 else flash.now[:notice] = "Message not deleted" end
  end

  def message_params
    params.require(:message).permit(:user_id, :conversation_id, :body)
  end
end