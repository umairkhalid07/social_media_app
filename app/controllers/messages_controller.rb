class MessagesController < ApplicationController
  def create
    @message = current_user.messages.new(message_params)
    @message.save!

    respond_to do |format|
      format.html { redirect_to conversation_path(params[:conversation_id]), notice: "Sent Message" }
      format.turbo_stream { redirect_to conversation_path(params[:conversation_id]), flash.now[:notice] => "Sent Message" }
    end
  end

  def message_params
    params.require(:message).permit(:user_id, :conversation_id, :body)
  end
end