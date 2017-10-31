require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  while character_hash
    character_hash["results"].find do |char_prof|
      if char_prof["name"].downcase == character.downcase
        return char_prof["films"].collect {|filmURL| JSON.parse(RestClient.get(filmURL))}
      end
    end
    if next?(character_hash)
      character_hash = JSON.parse(RestClient.get(character_hash["next"]))
    else
      break
    end
  end
end

# Check if the "next" attribute in character_hash is null 
def next?(character_hash)
  if character_hash["next"].class != String
    puts "Do you even Star Wars?"
    false
  else
    true
  end
end


def parse_character_movies(films_hash)
  if films_hash.class == Array
    films_hash.each.with_index {|film, index| puts "#{index + 1}. #{film["title"]}"}
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
