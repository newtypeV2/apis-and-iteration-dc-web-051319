require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  # iterate over the response hash to find the collection of `films` for the given
    character_info=response_hash["results"].find do |character|
      character["name"].downcase==character_name
    end
    if character_info!=nil
      character_info["films"].collect do |char|
        JSON.parse(RestClient.get(char))
      end
    else
      get_character_movies_from_api(get_valid_character_from_user)
    end
  end


  def get_valid_character_from_user
    puts "NAME NOT FOUND"
    puts "please enter a VALID character name:"
    # use gets to capture the user's input. This method should return that input, downcased.
    character = gets.chomp.downcase
  end

  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each_with_index do |films,index|
  puts "***************"
  puts "Movie: #{index+1} - Episode: #{films["episode_id"]} - #{films["title"]}"
  puts "***************"
  end

end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
