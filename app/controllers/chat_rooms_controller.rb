class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)

    if @chat_room.save
      redirect_to @chat_room, notice: 'Chat room created.'
    else
      render :new
    end
  end

  def create_chat_room
    @chat_room = ChatRoom.new(chat_room_params)

    if @chat_room.save
      redirect_to chat_rooms_path, notice: 'Chat room created.'
    else
      redirect_to chat_rooms_path, alert: 'Failed to create chat room.'
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
