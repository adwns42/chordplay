class ResultsController < ApplicationController
  def show
    if params[:search] == ""
      redirect_to root_path
    else
      @songs = Song.search(params[:search], params[:fewer], params[:more]).
        page(params[:page])
    end
  end
end
