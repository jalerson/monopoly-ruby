# Monopoly
This repo is the start of an implementation of the board game 'Monopoly'. The 'Sample' implementation uses a CLI UI to accept commands and print the state. A few game logic classes are provided to show a dummy game state in this UI.

## Prerequisites
* Ruby 2.5 or above
* Bundler

## Principles
* Any UI will use a playable (class that implements roll, new_game, current_player and players) to pass commands to the game logic and to retreive those objects it needs for printing the state.
* The game state should be stored within the classes, there is no database involved.

## Running
* Fork or clone this repo
* Install the dependencies
* Run 'bin/monopoly'

This will run the 'Sample' implementation with the CLI UI, which accepts (string) commands and prints the game state.

## Rules
The official game rules can be found on https://en.wikibooks.org/wiki/Monopoly/Official_Rules.
