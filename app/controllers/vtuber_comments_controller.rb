class VtuberCommentsController < ApplicationController

  def create
    vtuber =Vtuber.find(params[:vtuber_id])
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


end
