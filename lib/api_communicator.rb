require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

                # selected_character_data = []
                # character_hash["results"].each do |hsh|
                #
                #   if hsh["name"] == character
                #
                #     selected_character_data = hsh["films"]
                #   end
                # end


character_data = character_hash["results"].select { |hash| hash["name"] == character }
while character_data == []
  character_hash = JSON.parse(RestClient.get(character_hash["next"]))
  character_data = character_hash["results"].select { |hash| hash["name"] == character }
  #binding.pry
  if character_hash["next"] == nil && character_data == []
    return 0
  end
end


# loop do
#   if character_data == []
#     character_hash = JSON.parse(RestClient.get(character_hash["next"]))
#     character_data = character_hash["results"].select { |hash| hash["name"] == character }
#   elsif character_data["next"] == nil
#     puts "Sorry"
#   end
# end


  film_urls = character_data[0]["films"]
  film_urls.collect { |url| JSON.parse(RestClient.get(url))}

  #-------------------------------------
  # return_array =[]
  # selected_character_data.each do |url|
  #   new_info = RestClient.get(url)
  #   return_array << JSON.parse(new_info)
  # end
  # return_array
  #------------------------------------------
  #character_id.collect { |url| JSON.parse(RestClient.get(url))}




  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |hsh|
    puts hsh["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  if films_hash == 0
    puts "Sorry, doesn't exist"
    return
  end
  parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
