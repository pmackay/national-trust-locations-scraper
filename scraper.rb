require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new

PAGE = 'https://www.nationaltrust.org.uk/search?query=coventry&lat=52.406822&lon=-1.519692999999961&type=place&view=list&cardCount=9999'
# # Read in a page
page = agent.get(PAGE)

# # Find somehing on the page using css selectors
places = page.search('.nt-masonry-single-result')
places.each do |place|
  name = place.search 'h3'
  url = place.search('h3 a').attribute('href').value
  ScraperWiki.save_sqlite([:name], { name: name.text, url: url })
end
