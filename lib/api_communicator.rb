require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_hash["results"].collect do |x|
    if x["name"] == character
      return x
    end
  end
end


def parse_character_movies(films_hash)
  films_hash["films"]
end

def show_character_movies(character)
  character.each do |user_char|
    puts "-#{user_char}"
    films_hash = get_character_movies_from_api(user_char)
    parse_character_movies(films_hash).collect do |x|
      movie = RestClient.get(x)
      movie_hash = JSON.parse(movie)
      puts "--#{movie_hash["title"]}"
    end
  end

end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
