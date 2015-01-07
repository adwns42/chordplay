class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @bookmarks = user.bookmarked_songs
  end
end
