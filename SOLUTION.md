# Monopoly Coding Assessment

## Assumptions

Since it's not clearly stated in the coding challenge assessment description which parts of the project could be changed and which ones couldn't be, I've assumed there are no change restrictions. The only exception is what is stated by the first topic in the 'Principles' section of the README file.

> Any UI will use a playable (class that implements roll, new_game, current_player and players) to pass commands to the game logic and to retreive those objects it needs for printing the state.

Which means the `playable` must implement `roll`, `new_game`, `current_player` and `players`.

## Design patterns

### Builders

The Builder pattern was adopted to simplify the creation of complex types: `Monopoly::Board` and `Monopoly::Match`.

- `Monopoly::Board` instances can be created with custom sizes, different tile types and using customized services to change the logic of the game
- `Monopoly::Match` instances can be created with a customized number of players (from 2 to 4), different number of dices with a customized number of sides (minimum of 2) and a customized board

I've decided to use the Builder pattern because of the complexity involved when creating instances of these two classes.

### Decorators

The Decorator pattern was adopted to separate the presentation logic from the tiles and player data models.

### Services

The most complex logics of the game were encapsulated into service objects. Each service object performs only one task, which makes it easy to understand, maintain, test and even replaced, allowing to easily change the logic of the game.

## Design decisions

### Storing board tiles

While developing my solution, I needed to decide which data structure would store the tiles of the board. This decision must take into account:

- In a real board, when a player reaches the last tile, the player must jump to the first tile of the board
- In order to calculate the amount received by the player when overpassing Go tiles, the solution adopted would also need to provide these overpassed tiles

A potential solution for this problem could be a Circular Linked List, which consists of a conventional Linked List with a fundamental difference: the last node doesn't point to `nil`, but to the first node.

Although this solution is very intuitive and easy to implement, there's a drawback: because the typical way to access references in a Linked List is using the `next_node` method, every turn this method would be called N times, which N is the number rolled by the dices. Considering a match with two dices of 6 sides, N could be up to 12.

An alternative solution is using a regular array and calculate the final position of the player based on the number of the tiles on the board and also the number of steps.

The advantage of this solution is, having the starting position and the final position of the player, the overpassed tiles would be easy and fastly fetched by accessing the array using ranges.

That's why a regular array was used to store the tiles of the board.
