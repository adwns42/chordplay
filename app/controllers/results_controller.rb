class ResultsController < ApplicationController
  def show
    if params[:search] == ""
      redirect_to root_path
    else
      @songs = Song.search(params[:search])
    end
  end
end
