require_relative "../lib/scrapers/guitar_chord_dictionary.rb"

chord_list = GuitarChordDictionary.new.read_standardized_chords

chord_list.each do |name|
  Chord.create(name: name)
end
