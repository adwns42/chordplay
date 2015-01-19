class Song < ActiveRecord::Base
  has_and_belongs_to_many :chords
  has_many :bookmarks

  validates :source_url, presence: true, uniqueness: true
  validates :title, presence: true

  def self.search(search_string, fewer, more)
    searched_chords = search_string.split(/,\s+/)
    if fewer
      potential_songs = get_songs_inluding_fewer_than(searched_chords)
      remove_songs_with_unqueried_chords(potential_songs, searched_chords)
    elsif more
      get_songs_including_more_than(searched_chords)
    else
      get_songs_including_exactly(searched_chords)
    end
  end

  private

  def self.get_songs_inluding_fewer_than(searched_chords)
    select(:*).
      includes(:chords).
      where("chords_count <= ?", searched_chords.count).
      where(id: self.joins(:chords).
        where(chords: {name: searched_chords}).
        group("songs.id").
        pluck(:id)
      ).
      order(artist: :asc)
  end

  def self.remove_songs_with_unqueried_chords(potential_songs, searched_chords)
    trimmed_songs = []
    potential_songs.each do |song|
      return_song = true
      song.chords.each do |chord|
        if searched_chords.include?(chord.name) == false
          return_song = false
        end
      end
      trimmed_songs << song if (return_song == true)
    end
    return trimmed_songs
  end

  def self.get_songs_including_more_than(searched_chords)
    select(:*).
      includes(:chords).
      where(id: self.joins(:chords).
        where(chords: {name: searched_chords}).
        group("songs.id").
        having("COUNT(chords.id) = ?", searched_chords.count).
        pluck(:id)
      ).
      order(artist: :asc)
  end

  def self.get_songs_including_exactly(searched_chords)
    select(:*).
      includes(:chords).
      where("chords_count = ?", searched_chords.count).
      where(id: self.joins(:chords).
        where(chords: {name: searched_chords}).
        group("songs.id").
        having("COUNT(chords.id) = ?", searched_chords.count).
        pluck(:id)
      ).
      order(artist: :asc)
  end
end
