require_relative "./guitar_chord_dictionary.rb"
require_relative "./ultimate_guitar_crawler.rb"
require_relative "./ultimate_guitar_db_writer.rb"
require_relative "./ultimate_guitar_scraper.rb"
# require_relative "ultimate_guitar_song_saver.rb"

user_agent_string = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1)"\
                    "AppleWebKit/537.36 (KHTML, like Gecko)"\
                    "Chrome/41.0.2227.1"\
                    "Safari/537.36"

HEADERS_HASH = {"User-Agent" => user_agent_string}
SONG_RATING = 5
SLEEP_TIME = 1

CHORD_REFERENCE = GuitarChordDictionary.new.read

UltimateGuitarCrawler.new.run_advanced_search

# Ultimate Guitar advanced search params--
#  Only: chords, whole song, 5 stars
#  Any: level, tuning, version
