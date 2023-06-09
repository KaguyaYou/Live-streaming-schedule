class HomesController < ApplicationController
  def top
    @vtubers  = Vtuber.all.order(created_at: :desc)
  end

end
