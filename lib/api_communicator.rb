require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request

  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  all_chars_all_pages = []

  next_page = 1

  i = 1
  while next_page != nil
    all_chars_all_pages << JSON.parse(RestClient.get("https://www.swapi.co/api/people/?page=#{i}"))
    i += 1
    binding.pry
  end

  character_hash["results"].collect do |char_details_hsh|
    char_details_hsh["films"] if character == char_details_hsh["name"].downcase
  end.compact.flatten.collect do |movie_url|
    request = RestClient.get(movie_url)
    request_parsed = JSON.parse(request)
  end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.collect do |film|
    film["title"]
  end.join(", ")
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  # binding.pry
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
