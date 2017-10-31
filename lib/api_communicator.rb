require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request

  base_url = 'http://www.swapi.co/api/people/?page='
  pages = (1..9).to_a

  all_pages = pages.map do |page_num|
    base_url + page_num.to_s
  end

  character_hash = all_pages.map do |link|
    JSON.parse(RestClient.get(link))
  end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  char = character_hash.map do |page|
    page["results"]
  end


 result_arr = char.map do |item|
    item.find do |stat, data|
      stat["name"] == character
    end
  end.compact

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
