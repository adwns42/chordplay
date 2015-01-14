require_relative "../lib/scrapers/guitar_chord_dictionary.rb"

chord_list = GuitarChordDictionary.new.read_standardized_chords

chord_list.each do |name|
  Chord.create(name: name)
end

song_list = [
  ["Milne Hai Mujhse Aayi", "Arijit Singh", "http://tabs.ultimate-guitar.com/a/arijit_singh/milne_hai_mujhse_aayi_crd.htm", ["A", "B", "C"]],
  ["Thinking About You (ver 6)", "Frank Ocean", "http://tabs.ultimate-guitar.com/f/frank_ocean/thinking_about_you_ver6_crd.htm", ["D", "E", "F"]],
  ["Not About Angels", "Birdy", "http://tabs.ultimate-guitar.com/b/birdy/not_about_angels_crd_1476996id_20042014date.htm", ["G", "A", "B"]],
  ["I Don't Want To Talk About It", "Rod Stewart", "http://tabs.ultimate-guitar.com/r/rod_stewart/i_dont_want_to_talk_about_it_crd.htm", ["C", "D", "E"]]
]

song_list.each do |title, artist, source_url, chord_names|
  song = Song.create(title: title, artist: artist, source_url: source_url)
  chord_names.each do |chord_name|
    unless chord_name == ""
      chord = Chord.find_by(name: chord_name)
      song.chords << chord
    end
  end
end
