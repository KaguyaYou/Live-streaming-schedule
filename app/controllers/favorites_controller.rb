class FavoritesController < ApplicationController
  def create
    vtuber=Vtuber.find(params[:vtuber_id])
    @favorite=current_user.favorites.new(vtuber_id: vtuber.id)
    @favorite.save
    render 'create_btn'
  end

  def destroy
    vtuber=Vtuber.find(params[:vtuber_id])
    @favorite =current_user.favorites.find_by(vtuber_id: vtuber.id)
    @favorite.destroy
    render 'create_btn'
  end
end
