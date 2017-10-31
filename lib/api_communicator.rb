require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_hash["results"].collect do |char_prof|
    if char_prof["name"] == character
      return char_prof["films"].collect {|filmURL| JSON.parse(RestClient.get(filmURL))}
    end
  end
end

def parse_character_movies(films_hash)
  films_hash.each.with_index {|film, index| puts "#{index + 1}. #{film["title"]}"}
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
