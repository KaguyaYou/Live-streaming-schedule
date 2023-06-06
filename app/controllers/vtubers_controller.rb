class VtubersController < ApplicationController
  def index
    @total_vtubers =Vtuber.all
    @vtubers = Vtuber.all.page(params[:page]).per(8)
  end

  def show

  end

  def edit

  end

  def create

  end

  def destroy

  end

  def update

  end
end
