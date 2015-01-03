class UltimateGuitarScraper
  def scrape(link)
    create_parsable_song_page(link)
    self.song_attributes = {}
    get_song_attributes
    puts song_attributes
    return song_attributes
  end

  private

  attr_accessor(
    :artist,
    :chords,
    :n_page,
    :potential_chords,
    :song_attributes,
    :song_page,
    :title,
    :version
  )

  def create_parsable_song_page(link)
    open_song_page(link)
    convert_song_page_to_nokogiri
  end

  def open_song_page(link)
    self.song_page = open(link, HEADERS_HASH)
    sleep SLEEP_TIME
  end

  def convert_song_page_to_nokogiri
    self.n_page = Nokogiri::HTML(song_page)
  end

  def get_song_attributes
    get_artist
    get_chords
    get_version
    make_title
  end

  def get_artist
    song_attributes[:artist] = n_page.css("div.t_autor").css("a").text
  end

  def get_chords
    find_potential_chords
    remove_potential_chord_duplicates
    collect_chords_if_real
    standardize_chord_notation
  end

  def find_potential_chords
    self.potential_chords = n_page.css("pre").css("span").map do |element|
      element.text
    end
  end

  def remove_potential_chord_duplicates
    self.potential_chords = potential_chords.uniq
  end

  def collect_chords_if_real
    song_attributes[:chords] = potential_chords.map do |potential_chord|
      potential_chord if CHORD_REFERENCE.include? potential_chord
    end
    song_attributes[:chords].compact!
  end

  def standardize_chord_notation
    song_attributes[:chords].each do |chord|
      chord.gsub!(/(M|Maj|Major)/, "maj")
      chord.gsub!(/maj\b/, "")
      chord.gsub!(/(Minor|minor)/, "m")
    end
  end

  def get_version
    self.version = n_page.css("div.t_version").css("b").text
  end

  def make_title
    unedited_title = n_page.css("div.t_title").css("h1").text
    song_attributes[:title] = unedited_title.gsub!(/\sChords(?!.)/, "")
    unless version == ""
      song_attributes[:title] = "#{song_attributes[:title]} (#{version})"
    end
  end
end
