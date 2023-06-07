class VtubersController < ApplicationController
  def index
    @total_vtubers =Vtuber.all
    @vtubers = Vtuber.all.page(params[:page]).per(8)
    @vutuber= Vtuber.new
  end

  def show
    @vtuber = Vtuber.find(params[:id])
    @vtuber_new = Vtuber.new
    @vtuber_comment = VtuberComment.new
  end

  def edit
    @vtuber = Vtuber.find(params[:id])
  end

  def create
    @vtuber = Vtuber.new(vtuber_params)
    @vtuber.user_id = current_user_id
    if @vtuber.save
      flash[:notice]
      redirect_to vtuber_path(@vtuber)
    else
    end
  end

  def destroy

  end

  def update

  end
end
