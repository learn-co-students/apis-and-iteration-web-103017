require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  # INITIAL SOLUTION 
  #result_arr = []
  #character_hash["results"].each do |char|
  #  if char["name"] == character 
  #    char["films"].each do |url|
  #      result = JSON.parse(RestClient.get(url))
  #      result_arr << {result["title"] => result}
  #    end
  #  end
  #end

  # POSSIBLY BETTER SOLUTION

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  char = character_hash["results"]

  result_arr = char.select do |item|
    item["name"] == character
  end
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  result_arr[0]["films"].map do |url|
    result = JSON.parse(RestClient.get(url))
    {result["title"] => result}
  end  
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
   films_hash.each.with_index do |hsh, idx|
     puts "#{idx+1} #{hsh.keys.first}"
   end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
