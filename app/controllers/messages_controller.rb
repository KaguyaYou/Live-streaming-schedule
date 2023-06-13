class MessagesController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @message = @chat_room.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to @chat_room, notice: 'Message sent.'
    else
      redirect_to @chat_room, alert: 'Failed to send message.'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
