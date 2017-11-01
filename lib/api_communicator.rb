require 'rest-client'
require 'json'
require 'pry'


def all_characters_combined
  character_arr = []
  counter = 1

  until counter == 9
    all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{counter}")
    character_arr << character_hash = JSON.parse(all_characters)
    counter += 1
  end

  character_arr

end


def get_character_movies_from_api(character)
  #make the web request
  characters_arr = all_characters_combined
  # all_characters = RestClient.get('http://www.swapi.co/api/people/')
  # character_hash = JSON.parse(all_characters)
# condense?

  characters_arr.each do |character_hash|
    character_hash["results"].each do |hsh|
       hsh.each do |category, value|
         if category == "name"
           if value.downcase == character
             return hsh["films"].collect do |links|
               JSON.parse(RestClient.get(links))
             end
           end
         end
       end
    end
  end



  # character_hash["results"].each do |hsh|
  #   hsh.each do |category, value|
  #     binding.pry
  #     until hsh.values.downcase.include?(character)
  #       character_hash = JSON.parse(ResClient.get(character_hash["next"]))
  #     end
  #     hsh.each do |category, value|
  #       if category == "name"
  #         if value.downcase == character
  #           return hsh["films"].collect do |links|
  #             JSON.parse(RestClient.get(links))
  #           end
  #         end
  #       end
  #     end
  #   end


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

def parse_character_movies(films_hash) #assuming films_hash == get_character_movies_from_api
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |hsh|
    hsh.each do |category, value|
      if category == "title"
        puts value
      end
    end
  end
end

def show_character_movies(character)
   films_hash = get_character_movies_from_api(character)
   parse_character_movies(films_hash)

  # parse_character_movies(film_results(character))
end

# Helper methods

def get_film_list(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
# might need to refactor
  character_hash["results"].each do |hsh|
     hsh.each do |category, value|
       if category == "name"
         if value.downcase == character
           return hsh["films"]
         end
       end
     end
  end
end

def get_film_info(film_arr)
  film_arr.collect do |links|
    JSON.parse(RestClient.get(links))
  end
end

def film_results(character)
  film_arr = get_film_list(character)
  get_film_info(film_arr)
end

# Checks to make sure character exists
# haven't perfected
#
# def valid_input(character)
#   get_film_list(character).class == Array
# end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
