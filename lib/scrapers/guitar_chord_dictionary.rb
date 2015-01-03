class GuitarChordDictionary
  def initialize
    @roots = [
      "C", "C#",
      "Db", "D", "D#",
      "Eb", "E",
      "F", "F#",
      "Gb", "G", "G#",
      "Ab", "A", "A#",
      "Bb", "B"
    ]
    @qualities_and_intervals = [
      "",
      "M", "Maj", "Major", "maj",
      "maj7", "maj9", "maj13", "maj9#11", "maj13#11",
      "6", "add9", "6add9",
      "maj7b5", "maj7#5",
      "Minor", "m",
      "m7", "m9", "m11", "m13",
      "m6", "madd9", "m6add9",
      "mmaj7", "mmaj9",
      "m7b5", "m7#5",
      "7", "9", "11", "13",
      "7sus4", "7b5", "7#5", "7b9", "7#9",
      "7(b5,b9)", "7(b5,#9)", "7(#5,b9)", "7(#5,#9)",
      "9b5", "9#5", "13#11", "13b9", "11b9",
      "aug", "dim", "dim7", "5",
      "sus4", "sus2", "sus2sus4", "-5",
    ]

    @standardized_qualities_and_intervals = [
      "",
      "maj7", "maj9", "maj13", "maj9#11", "maj13#11",
      "6", "add9", "6add9",
      "maj7b5", "maj7#5",
      "m", "m7", "m9", "m11", "m13",
      "m6", "madd9", "m6add9",
      "mmaj7", "mmaj9",
      "m7b5", "m7#5",
      "7", "9", "11", "13",
      "7sus4", "7b5", "7#5", "7b9", "7#9",
      "7(b5,b9)", "7(b5,#9)", "7(#5,b9)", "7(#5,#9)",
      "9b5", "9#5", "13#11", "13b9", "11b9",
      "aug", "dim", "dim7", "5",
      "sus4", "sus2", "sus2sus4", "-5",
    ]

    @slashes = [
      "", "/C", "/C#", "/Db", "/D", "/D#", "/Eb", "/E", "/F", "/F#",
      "/Gb", "/G", "/G#", "/Ab", "/A", "/A#","/Bb", "/B"
    ]
  end

  def read
    self.all_chords = []
    assemble_chords
    return all_chords
  end

  def read_standardized_chords
    self.standardized_chords = []
    assemble_standardized_chords
    return standardized_chords
  end

  private

  attr_accessor :all_chords, :standardized_chords
  attr_reader(
    :roots,
    :qualities_and_intervals,
    :standardized_qualities_and_intervals,
    :slashes
  )

  def assemble_chords
    roots.each do |root|
      add_qualities_intervals_and_slashes(root)
    end
  end

  def add_qualities_intervals_and_slashes(root)
    qualities_and_intervals.each do |quality_and_interval|
      slashes.each do |slash|
        all_chords << root + quality_and_interval + slash
      end
    end
  end

  def assemble_standardized_chords
    roots.each do |root|
      add_standardized_qualities_intervals_and_slashes(root)
    end
  end

  def add_standardized_qualities_intervals_and_slashes(root)
    standardized_qualities_and_intervals.each do |quality_and_interval|
      slashes.each do |slash|
        standardized_chords << root + quality_and_interval + slash
      end
    end
  end
end
