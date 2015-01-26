# Chordplay

[Chordplay](https://chordplay.herokuapp.com/) is a Heroku-deployed web application for guitar instruction, learning, and casual play.

Chordplay allows users to search for songs that contain the chords they know or want to learn. All songs are aggregated from online guitar tablature databases like <a href"=http://www.ultimate-guitar.com">Ultimate-Guitar</a>, and presented as links to their respective song pages on those databases.

Guests and users alike may input chords to see a list of songs that contain them. A signed-in user gains the ability to bookmark songs for viewing on their personal bookmarked-songs page.

### Under the hood

Chordplay makes use of a custom-built crawler to navigate the pages of Ultimate-Guitar in search of songs matching specific criteria. Songs must have chord notation, be full songs, and be rated 5 stars. It then employs a custom scraper to pull artist, title and chord information and create the appropriate database associations. HTML parsing is accomplished with the wonderful [Nokogiri](https://github.com/sparklemotion/nokogiri) gem.

### Work to be done

I want this application to be accessible to everyone and to run smoothly even though it's not deployed with a professional Heroku plan. Currently Heroku doesn't deal well with the complicated SQL I use to provide the app's core search functionality, so I'm exploring integrating NoSQL options like [elasticsearch](http://www.elasticsearch.org/). 
I also hope to expand beyond Ultimate-Guitar in the near future, with new custom crawler/scrapers.

Check back soon!
