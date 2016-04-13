Helper = require 'hubot-test-helper'
chai = require 'chai'
nock = require 'nock'

expect = chai.expect

pokemoduleDummyData = require './pokemodule-test-data'
thingsUsersSay =
  'user1': 'hubot who\'s that pokemon?'
  'user2': 'hubot who is that pokemon?'
  'user3': 'hubot who’s that pokemon?'

helper = new Helper('../src/pokemodule.coffee');

describe 'pokemodule', ->
  room = null
  pokemonAPIDomain = 'http://pokeapi.co'
  pokemonFormNock = null
  PokeModule = require '../src/PokeModuleClass'
  pokeDex = new PokeModule pokemonAPIDomain
  hubotResponse =  [ 'hubot', """
                     http://pokeapi.co/media/sprites/pokemon/1.png
                     ... Its Bulbasaur!
                     """ ]
  beforeEach ->
    room = helper.createRoom()
    do nock.disableNetConnect
    pokemonFormNock = nock(pokemonAPIDomain)
      .get(/\/api\/v2\/pokemon-form\/\d/)
      .reply 200, pokemoduleDummyData.pokemon_form

  afterEach ->
    room.destroy()
    nock.cleanAll()

  it 'getRandomIntInclusive returns number within limits', ->
    expect(pokeDex.getRandomIntInclusive(1,152)).to.be.within(1,152)

  it 'capitalizes pokemon name', ->
    expect(pokeDex.capitalize('bulbasaur')).to.equal('Bulbasaur')

  describe 'http endpoints', ->
    for user, message of thingsUsersSay
      context "#{user} asks \"#{message}\"", ->
        beforeEach (done) ->
          room.user.say "#{user}", "#{message}"
          setTimeout done, 100
        it 'should respond with a pokemon url and its name', ->
          expect(room.messages).to.eql [
            ["#{user}", "#{message}"]
              hubotResponse
            ]