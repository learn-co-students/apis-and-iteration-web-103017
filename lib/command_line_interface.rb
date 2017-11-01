def welcome
  puts "Welcome to Star Wars"
end

def get_character_from_user
  puts "Please enter a character or characters separated by ','"
  gets.chomp.split(", ")
  # use gets to capture the user's input. This method should return that input, downcased.
end
