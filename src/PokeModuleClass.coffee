# Description:
#   Some helpers to communicate with the Poke API
#
# Dependencies:
#   none
#
# Configuration:
#   none
#
# Commands:
#   hubot who is that pokemon?
#
# Author:
#   Eduardo Guanilo (eduardo.guanilo@complex.com)
#   Hector Leiva (hector.leiva@complex.com)

class Pokemodule

  constructor: (@baseUrl) ->

# Shamelessly copied from MDN
# Gets a random number between min to max, including min and max
  getRandomIntInclusive: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min


# Helper to capitalize the first letter of the pokémon's name
  capitalize: (words = "") ->
    (words.split(' ').map (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join ' '

# Sends a request to the PokéAPI for the sprite and its metadata
# the index is the id of the pokémon in question
  getPkmn: (robot, index, callback) ->

    # build the url for the PokéAPI v2 GET request
    spriteUrl = "#{@baseUrl}/api/v2/pokemon-form/#{index}/"

    robot.http(spriteUrl).get() (error, response, body) ->
      pokedata = JSON.parse(body)

      # something went wrong, abort mission
      if error or pokedata.detail is 'Not found.'
        callback(true)
      else
        callback(false, pokedata.name, pokedata.sprites.front_default)

module.exports = Pokemodule