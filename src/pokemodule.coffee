# Description:
#   Let's figure out who that pokemon is
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

## The poor souls who are hosting this API, bless them
baseURL = 'http://pokeapi.co'

Pokemodule = require './PokeModuleClass'

pokedex = new Pokemodule baseURL

module.exports = (robot) ->

  robot.respond /(who is|who’s|who\'s) that (pokemon|pokémon)/i, (msg) ->
    # only Gen 1 pokémon for now, because we're old
    # this will be passed to the PokéAPI as the id value of the pokémon
    randomId = pokedex.getRandomIntInclusive 1, 152

    pokedex.getPkmn robot, randomId, (err, name, imageURL) ->
      if err
        msg.send('Team Rocket is blasting off again!')
      else
        msg.send("""
                 #{imageURL}
                 ... Its #{pokedex.capitalize name}!
                 """)