require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  output = []
  while character_hash
    found_char = character_hash['results'].find do |individual_character|
      individual_character['name'] == character
      #puts individual_character['films']
    end
    if found_char
      found_char['films'].each do |link|
        movie_info = RestClient.get(link)
        output << JSON.parse(movie_info)
      end
      break
    end
    character_hash = character_hash['next'] ? JSON.parse(RestClient.get(character_hash['next']) ) : nil
  end
  output
end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film

def parse_character_movies(films_hash)
  films_hash.each_with_index do | film, index |
    puts "#{index + 1} #{film["title"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
