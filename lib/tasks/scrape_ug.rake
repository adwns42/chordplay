require_relative "../scrapers/ultimate_guitar_main.rb"

task :scrape_ug => :environment do
  ruby ultimate_guitar_main.rb
end
