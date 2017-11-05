require 'rest-client'
require 'json'
require 'pry'
require 'faraday'


def get_character_movies_from_api(character)
  #make the web request
  def get_film_urls(character)
    # all_characters = RestClient.get('https://swapi.co/api/people/')
    # character_hash = JSON.parse(all_characters)

    # This solution below misses a page, since condition will never be true for last page
    # counter =1
    # star_wars_characters = []
    # page = JSON.parse(RestClient.get("https://www.swapi.co/api/people/?page=#{counter}"))["next"]
    #
    # while page
    #   star_wars_characters << JSON.parse(RestClient.get("https://www.swapi.co/api/people/?page=#{counter}"))["results"]
    #   counter += 1
    #   page = JSON.parse(RestClient.get("https://www.swapi.co/api/people/?page=#{counter}"))["next"]
    # end
    #
    # star_wars_characters.flatten!
    total_thespians = JSON.parse(RestClient.get('https://swapi.co/api/people/'))["count"]

    counter = 1
    star_wars_characters = []
    status = Faraday.get("https://swapi.co/api/people/#{counter}/").status

    while counter <= total_thespians
      if status == 200
        star_wars_characters << JSON.parse(RestClient.get("https://swapi.co/api/people/#{counter}/"))
        counter += 1
        status = Faraday.get("https://swapi.co/api/people/#{counter}/").status
      else
        counter += 1
        total_thespians += 1
        status = Faraday.get("https://swapi.co/api/people/#{counter}/").status
      end
      # binding.pry
    end

    star_wars_characters.find{|star| star["name"].downcase == character}["films"]
    # iterate over the character hash to find the collection of `films` for the given
    #   `character`
    # collect those film API urls, make a web request to each URL to get the info
    #  for that film
    # return value of this method should be collection of info about each film.
    #  i.e. an array of hashes in which each hash reps a given film
    # this collection will be the argument given to `parse_character_movies`
    #  and that method will do some nice presentation stuff: puts out a list
    #  of movies by title. play around with puts out other info about a given film.

    # binding.pry
    # film_urls = char_stats[character].select{|stats| char_stats["films"]}
    #UPDATE: THink about replacing [0] with a better idea
    #ANS: Did it with find

  end

  def get_films(film_urls)
    film_urls.map do |film_url|
      JSON.parse(RestClient.get(film_url))
    end
  end
  # film_urls.inject([]) do |film_info, film_url|
  #   filmzz = JSON.parse(RestClient.get(film_url))
  #   film_info << filmzz
  #   film_info
  # end
  #ASK Q: How do you test the value of an inject output like film_info above with binding.pry

  films_urls = get_film_urls(character)
  get_films(films_urls)

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
