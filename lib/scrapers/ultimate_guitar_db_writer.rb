class UltimateGuitarDbWriter
  def save(info, link)
    add_song_to_db(info, link)
  end

  private

  attr_accessor :song

  def add_song_to_db(info, link)
    unless Song.exists?(source_url: link)
      self.song = Song.new(
        title: info[:title],
        artist: info[:artist],
        source_url: link
      )
      if song.save
        create_chord_associations(info)
        puts "#{info[:title]} written to DB"
      else
        puts "#{info[:title]} did not pass validation"
      end
    end
  end

  def create_chord_associations(info)
    chord_names = info[:chords]
    chord_names.each do |chord_name|
      unless chord_name == nil
        chord = Chord.find_by(name: chord_name)
        song.chords << chord
      end
    end
  end
end
