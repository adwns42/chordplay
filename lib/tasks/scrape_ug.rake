task :scrape_ug => :environment do
  desc "Run song and chord scraper for Ultimate-Guitar.com"
  require_relative "../scrapers/ultimate_guitar_main.rb"
  ruby ultimate_guitar_main.rb
end
