require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)

  all_chars_all_pages = []
  i = 1
  
  #collect data from all pages and store in all_chars_all_pages
  while JSON.parse(RestClient.get("https://www.swapi.co/api/people/?page=#{i}"))["next"]
    all_chars_all_pages << JSON.parse(RestClient.get("https://www.swapi.co/api/people/?page=#{i}"))["results"]
    i += 1
  end

  all_chars_all_pages.flatten!

  # 1st collect grabs list of films actor has played in, 2nd collect
  # grabs details of movie for each movie url provided in step 1
  all_chars_all_pages.collect do |char_details_hsh|
    char_details_hsh["films"] if character == char_details_hsh["name"].downcase
  end.compact.flatten.collect do |movie_url|
    request = RestClient.get(movie_url)
    request_parsed = JSON.parse(request)
  end


end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.collect do |film|
    film["title"]
  end.join(", ")
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
