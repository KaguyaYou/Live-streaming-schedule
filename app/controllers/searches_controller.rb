class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
     @method = params[:method]

    if @model =='user'
      @records = User.looks(@content, @method)
    else
      @records = Vtuber.looks(@content, @method)
    end

  end
end
