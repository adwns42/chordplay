class Song < ActiveRecord::Base
  has_and_belongs_to_many :chords
  has_many :bookmarks

  validates :source_url, presence: true, uniqueness: true
  validates :title, presence: true

  def self.search(search_string)
    searched_chords = search_string.split(/,\s+/)
    get_songs_including_searched_chords_only(searched_chords)
  end

  private

  def self.get_songs_including_searched_chords_only(searched_chords)
    potential_songs = songs_with_searched_chords(searched_chords)
    songs_without_extra_chords(potential_songs, searched_chords)
  end

  def self.songs_with_searched_chords(searched_chords)
    select(:*).includes(:chords).where(id:
      self.joins(:chords).
      where(chords: {name: searched_chords}).
      group("songs.id").
      having("COUNT(chords.id) = #{searched_chords.count}").
      pluck(:id)
    ).
    order(artist: :asc)
  end

  def self.songs_without_extra_chords(potential_songs, searched_chords)
    potential_songs.map do |song|
      song unless chord_num_mismatch?(song.chords, searched_chords)
    end.compact
  end

  def self.chord_num_mismatch?(song_chords, searched_chords)
    song_chords.count > searched_chords.count
  end
end
