class ChatsController < ApplicationController
  before_action :set_group

  def create
    @chat = @group.chats.new(chat_params)
    @chat.user_id = current_user.id

    if @chat.save
      redirect_to group_path(@group), notice: 'メッセージが投稿されました。'
    else
      redirect_to group_path(@group), notice: 'メッセージが送信できませんでした。'
    end
  end



  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def chat_params
    params.require(:chat).permit(:message)
  end
end
