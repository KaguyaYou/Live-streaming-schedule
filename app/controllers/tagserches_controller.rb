class TagserchesController < ApplicationController
  def search
    @model = Vtuber  #search機能とは関係なし
    @word = params[:content]
    @vtubers = Vtuber.where("category LIKE?","%#{@word}%")
    render "tagsearches/tagsearch"
  end
end
