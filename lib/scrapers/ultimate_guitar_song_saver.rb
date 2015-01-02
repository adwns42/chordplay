require "csv"

class UltimateGuitarSongSaver
  def save(info, link)
    add_to_csv(info, link)
  end

  private

  def add_to_csv(info, link)
    unless File.exists?("song_db_standin")
      Dir.mkdir("song_db_standin")
    end
    unless File.exists?("song_db_standin/songs.csv")
      CSV.open("song_db_standin/songs.csv", "w") do |file|
        file << ["Title", "Artist", "Rating", "Chords", "Link"]
      end
    end
    CSV.open("song_db_standin/songs.csv", "r+") do |file|
      unless file.read.include?(link)
        file << [info[:title], info[:artist], SONG_RATING, info[:chords].join("\s"), link]
        puts "#{info[:title]} written to CSV"
      end
    end
  end
end
