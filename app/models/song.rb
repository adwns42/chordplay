class Song < ActiveRecord::Base
  has_and_belongs_to_many :chords
  has_many :bookmarks

  validates :source_url, presence: true, uniqueness: true
  validates :title, presence: true

  def self.search(search_string)
    searched_chords = search_string.split(/,\s+/)
    get_songs_with_all_and_only(searched_chords)
  end

  private

  def self.get_songs_with_all_and_only(searched_chords)
    select(:*).
      includes(:chords).
      where("chords_count = ?", searched_chords.count).
      where(id: self.joins(:chords).
        where(chords: {name: searched_chords}).
        group("songs.id").
        having("COUNT(chords.id) = #{searched_chords.count}").
        pluck(:id)
      ).
      order(artist: :asc)
  end
end
