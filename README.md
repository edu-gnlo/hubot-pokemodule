# hubot-pokemodule

A hubot script that that fetches a random pokemon image and its name from the
PokeAPI

See [`src/pokemodule.coffee`](src/pokemodule.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-pokemodule --save`

Then add **hubot-pokemodule** to your `external-scripts.json`:

```json
["hubot-pokemodule"]
```

## Sample Interaction

```
user1>> hubot who's that pokemon?
hubot>> http://pokeapi.co/media/sprites/pokemon/1.png
        ... Its Bulbasaur!
```
