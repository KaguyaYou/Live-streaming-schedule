class TagserchesController < ApplicationController
  def search
    @model = Vtuber
    @word = params[:content]
    @vtubers = Vtuber.where("category LIKE ?", "%#{@word}%")
    render "tagsearches/tagsearch"
  end
end