class BookmarksController < ApplicationController
  def create
    song = Song.find(params[:song_id])
    current_user.bookmark(song)

    redirect_to :back
  end

  def destroy
    song= Song.find(params[:song_id])
    current_user.unbookmark(song)

    redirect_to :back
  end
end
