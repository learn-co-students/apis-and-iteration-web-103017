#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
character = get_character_from_user
# Started to check for valid input -- haven't perfected
# until valid_input(character) == true
#   puts "Sorry that character does not exist."
#   character = get_character_from_user
# end
show_character_movies(character)
