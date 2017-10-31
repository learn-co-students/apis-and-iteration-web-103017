def welcome
  puts "What up! Wanna know some Star Wars stuff???"

end

def get_character_from_user
  puts "please enter a character"
  character = gets.chomp
  character
  # use gets to capture the user's input. This method should return that input, downcased.
end
