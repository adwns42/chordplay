class AddChordsCountToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :chords_count, :integer, default: 0, index: true

    Song.reset_column_information
    Song.includes(:chords).each do |song|
      song.update_attribute :chords_count, song.chords.count
    end
  end
end
