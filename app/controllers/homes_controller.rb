class HomesController < ApplicationController
  def top
    @vtubers  = Vtuber.all.order(created_at: :desc)
    @vtubers =Vtuber.where(status: true)
  end

end
