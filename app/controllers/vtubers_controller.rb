class VtubersController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]

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

    @vtuber = current_user.vtubers.new(vtuber_params)
    if @vtuber.save
      flash[:notice]
      redirect_to vtubers_path
    else
      render :new
    end
  end

  def destroy
    @vtuber = Vtuber.find(params[:id])
    @vtuber.destroy
    redirect_to "/vtubers"
  end

  def update
    @vtuber = Vtuber.find(params[:id])
    if @vtuber.update(vtuber_params)
      flash[:notice] = "You have created vtuber successfully."
      redirect_to vtuber_path(@vtuber.id)
    else
      render "edit"
    end
  end

  private

  def vtuber_params
    params.require(:vtuber).permit(:name,:belonging_office,:fan_name,:debut_day,:registered_person,:profile,:image,:user_id,:category)
  end
end