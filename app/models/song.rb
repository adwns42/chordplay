class Song < ActiveRecord::Base
  has_and_belongs_to_many :chords
  has_many :bookmarks
  has_many :users, through: :bookmarks

  validates :source_url, presence: true, uniqueness: true
  validates :title, presence: true

  def self.search(search_string, option)
    searched_chords = search_string.split(/,\s+/)
    get_chords_with_option(searched_chords, option)
  end

  private

  def self.get_chords_with_option(searched_chords, option)
    if option == "fewer"
      get_songs_inluding_fewer_than(searched_chords)
    elsif option == "more"
      get_songs_including_more_than(searched_chords)
    elsif option == "any"
      get_songs_including_any(searched_chords)
    else
      get_songs_including_exactly(searched_chords)
    end
  end

  def self.get_songs_inluding_fewer_than(searched_chords)
    potential_songs = get_songs_with_same_num_chords_as(searched_chords)
    song_arr = songs_with_only_searched_chords(potential_songs, searched_chords)
    make_paginatable(song_arr)
  end

  def self.get_songs_with_same_num_chords_as(searched_chords)
    select(:*).
      where("chords_count <= ?", searched_chords.count).
      where(id: self.joins(:chords).
        where(chords: {name: searched_chords}).
        group("songs.id").
        pluck(:id)
      )
  end

  def self.songs_with_only_searched_chords(potential_songs, searched_chords)
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

  def self.make_paginatable(song_arr)
    Kaminari.paginate_array(song_arr)
  end

  def self.get_songs_including_more_than(searched_chords)
    select(:*).
      where(id: self.joins(:chords).
        where(chords: {name: searched_chords}).
        group("songs.id").
        having("COUNT(chords.id) = ?", searched_chords.count).
        pluck(:id)
      )
  end

  def self.get_songs_including_any(searched_chords)
    select(:*).
      where(id: self.joins(:chords).
        where(chords: {name: searched_chords}).
        group("songs.id").
        pluck(:id)
      )
  end

  def self.get_songs_including_exactly(searched_chords)
    select(:*).
      where("chords_count = ?", searched_chords.count).
      where(id: self.joins(:chords).
        where(chords: {name: searched_chords}).
        group("songs.id").
        having("COUNT(chords.id) = ?", searched_chords.count).
        pluck(:id)
      )
  end
end
