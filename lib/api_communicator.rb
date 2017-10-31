require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('https://swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  char_stats = character_hash["results"]
  # binding.pry
  # film_urls = char_stats[character].select{|stats| char_stats["films"]}
  #UPDATE: THink about replacing [0] with a better idea
  # film_urls = char_stats.select{|stats| stats["name"].downcase == character}[0]["films"]
  film_urls = char_stats.find{|stats| stats["name"].downcase == character}["films"]

  film_urls.inject([]) do |film_info, film_url|
    # binding.pry

    filmzz = JSON.parse(RestClient.get(film_url))
    film_info << filmzz
    film_info
  end
  #ASK Q: How do you test the value of an inject output like film_info above with binding.pry

  # film_urls.map do |film_url|
  # filmzz = JSON.parse(RestClient.get(film_url))
end

end

# get_character_movies_from_api("Luke Skywalker")

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each.with_index(1) do |films, index|
    puts "#{index}. #{films["title"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
#
# films_hash = get_character_movies_from_api("Luke Skywalker")
# parse_character_movies(films_hash)

# show_character_movies("Luke Skywalker")

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
