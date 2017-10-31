require 'rest-client'
require 'json'
require 'pry'

require_relative "../lib/command_line_interface.rb"


def get_character_array(character)
  film_apis = [] 
  until film_apis != []
    all_characters = RestClient.get('http://www.swapi.co/api/people/')
    character_hash = JSON.parse(all_characters)
    character_array = character_hash["results"]
    character_array.each do |character_hash|
      if character_hash["name"] == character
        film_apis = character_hash["films"]
      end
    end
    if film_apis == []
      puts "We don't have information on that character, please try again."
      character = get_character_from_user
    else 
      return film_apis
    end
  end
end

def get_film_apis(film_apis)
  film_hash ={}
  film_apis.collect do |film_api|
    film = RestClient.get(film_api)
    film_hash = JSON.parse(film)
  end
end

def parse_character_movies(films_hash)
  films_hash.collect do |item|
    item["title"]
  end 
end

def show_character_movies(character)
  film_apis = get_character_array(character)
  films_hash = get_film_apis(film_apis)
  puts parse_character_movies(films_hash).flatten
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
