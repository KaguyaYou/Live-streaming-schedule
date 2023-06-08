class VtubersController < ApplicationController
  def index
    @total_vtubers =Vtuber.all
    @vtubers = Vtuber.all.page(params[:page]).per(8)
    @vtuber= Vtuber.new
  end

  def new
    @vtuber =Vtuber.new
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
    if @vtuber.save
      flash[:notice]
      redirect_to vtubers_path
    else
      render :new
    end
  end

  def destroy

  end

  def update

  end

  private

  def vtuber_params
    params.require(:vtuber).permit(:name,:belonging_office,:fan_name,:debut_day,:registered_person,:profile,:image)
  end
end