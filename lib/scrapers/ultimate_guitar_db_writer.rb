class UltimateGuitarDbWriter
  def save(info, link)
    add_song_to_db(info, link)
  end

  private

  def add_song_to_db(info, link)
    song = Song.new(
      title: info[:title],
      artist: info[:artist],
      source_url: link,
    )
    if song.save
      create_chord_associations(song, info[:chords])
      puts "***#{info[:title]} written to DB with #{song.chords_count} "\
      "chords***"
    else
      puts "***#{info[:title]} did not pass validation***"
    end
  end

  def create_chord_associations(song, chord_names)
    chord_names.each do |chord_name|
        chord = Chord.find_by(name: chord_name)
        song.chords << chord
    end
  end
end
