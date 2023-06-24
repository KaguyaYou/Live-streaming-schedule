class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @search = params[:search]
     @word = params[:word]
    p @search

    if @model =='user'
      @records = User.looks(@search, @word)
    else
      @records = Vtuber.looks(@search, @word)
    end

  end
end
