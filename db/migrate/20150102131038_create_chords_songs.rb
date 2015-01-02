class CreateChordsSongs < ActiveRecord::Migration
  def change
    create_table :chords_songs do |t|
      t.references :chord, index: true
      t.references :song, index: true
    end
  end
end
