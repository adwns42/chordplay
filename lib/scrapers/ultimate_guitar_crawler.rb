class UltimateGuitarCrawler
  require "nokogiri"
  require "open-uri"
  require "rubygems"

  def initialize
    @saver = UltimateGuitarDbWriter.new
    @scraper = UltimateGuitarScraper.new
    @search_strings = assemble_search_strings.flatten
  end

  def run_advanced_search
    search_strings.each do |search_string|
      puts "Running advanced search with string '#{search_string}'"
      self.search_string = search_string
      collect_song_links
      remove_song_links_already_in_database
      scrape_song_info_to_database
    end
    puts "Finished scraping."
    exit
  end

  private

  attr_accessor(
    :n_page,
    :results_page,
    :search_string,
    :search_strings,
    :song_links,
  )

  attr_reader :saver, :scraper

  def assemble_search_strings
    ("A".."Z").map do |first_letter|
      ("A".."Z").map do |second_letter|
        first_letter + second_letter
      end
    end
  end

  def collect_song_links
    self.song_links = []
    (1..10).each do |page_num|
      puts "Inspecting results page #{page_num}"
      create_parsable_results_page(page_num)
      break if no_results? == true
      parse_page_for_real_links
    end
    song_links.uniq!
  end

  def create_parsable_results_page(page_num)
    url = get_results_page_url(page_num)
    attempts_failed = 0
    open_results_page(url, attempts_failed)
    convert_results_page_to_nokogiri_doc
    results_page.close
  end

  def get_results_page_url(page_num)
    "http://www.ultimate-guitar.com/search.php?"\
    "song_name=#{search_string}&type%5B2%5D=300&type2%5B0%5D=40000"\
    "&rating%5B4%5D=#{SONG_RATING}&page=#{page_num}&view_state=advanced&"\
    "tab_type_group=text&app_name=ugt&order=myweight"
  end

  def open_results_page(url, attempts_failed)
    if attempts_failed < 5
      begin
        self.results_page = open(url, HEADERS_HASH)
        sleep SLEEP_TIME
      rescue OpenURI::HTTPError => error
        puts "***HTTP ERROR #{error.io.status[0]}, TRYING AGAIN IN 5***"
        results_page.close
        sleep 5

        attempts_failed += 1
        open_results_page(url, attempts_failed)
        sleep SLEEP_TIME
      end
    else
      puts "***FAILED 5 TIMES, EXITING***"
      exit
    end
  end

  def convert_results_page_to_nokogiri_doc
    self.n_page = Nokogiri::HTML(results_page)
  end

  def no_results?
    if n_page.css("td.sres").css("div.not_found").text == ""
      return false
    end
    return true
  end

  def parse_page_for_real_links
    n_page.css("a.song").each do |potential_link|
      collect_if_real(potential_link)
    end
  end

  def collect_if_real(potential_link)
    link = potential_link["href"]
    if link.include?("http://tabs.ultimate-guitar.com/")
      song_links << link
    end
  end

  def remove_song_links_already_in_database
    song_links_in_db = Song.pluck(:source_url)
    self.song_links = song_links - song_links_in_db
  end

  def scrape_song_info_to_database
    if song_links.any?
      puts "#{song_links.count} new songs found"
      song_links.each do |song_link|
        scraped_info = scraper.scrape(song_link)
        saver.save(scraped_info, song_link)
        puts "#{Song.count(:id)} songs saved"
      end
    else
      puts "No new songs found"
    end
  end
end
