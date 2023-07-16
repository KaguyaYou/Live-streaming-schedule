class VtuberCommentsController < ApplicationController
  before_action :authenticate_user!, except: [:create, :destroy]

  def create
    vtuber =Vtuber.find(params[:vtuber_id])

    if current_user.nil?
      flash[:notice] = "コメントするにはログインが必要です。"
      redirect_to new_user_session_path
      return
    end


    comment = current_user.vtuber_comments.new(vtuber_comment_params)
    comment.vtuber_id = vtuber.id
    comment.save
    redirect_to vtuber_path(vtuber)
  end

  def destroy
    VtuberComment.find(params[:id]).destroy
    redirect_to vtuber_path(params[:vtuber_id])
  end

  private

  def vtuber_comment_params
    params.require(:vtuber_comment).permit(:vtuber_id,:comment,:content,:user_id)
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end
