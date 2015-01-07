class User < ActiveRecord::Base
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable
  )

  has_many :bookmarks
  has_many :bookmarked_songs, through: :bookmarks, source: :song

  def bookmark(song)
    bookmarked_songs << song
  end

  def unbookmark(song)
    bookmarked_songs.delete(song)
  end

  def bookmarked?(song)
    bookmarked_songs.include? song
  end
end
