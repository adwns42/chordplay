class ResultsController < ApplicationController
  def show
    if params[:search] == ""
      redirect_to :back
    else
      @songs = Song.
        search(params[:search], params[:option]).
        includes(:chords).
        includes(:users).
        order(artist: :asc).
        page(params[:page])
    end
  end
end
