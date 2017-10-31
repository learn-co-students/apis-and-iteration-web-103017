require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)

  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash1 = JSON.parse(all_characters)

  more_characters = RestClient.get('https://www.swapi.co/api/people/?page=2')
  character_hash2 = JSON.parse(more_characters)

  character_hash = character_hash1.merge(character_hash2)

  target = character_hash["results"]
  film_array = []

  target.select do |hash|
    if hash["name"] == character
      hash["films"].collect do |film|
         film_array << JSON.parse(RestClient.get(film))
      end
    end
  end
  film_array
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

def parse_character_movies(films_hash)
  films_hash.collect do |hash|
    puts hash["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?


# SECOND ADD YULIA ATTEMPT
