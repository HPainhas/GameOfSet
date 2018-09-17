# GameOfSet

## Getting Started
These instructions will show you how to get a copy of this project on your machine and how to use the software.

### Prerequisites
Make sure you have [git](https://git-scm.com/) and [Ruby 2.5.1](https://ruby-doc.org/) installed. Refer to the links on how to install them.

### Installation
Clone the repo using

```
git clone https://github.com/cse3901-2018au-1730/The330GameOfSet
```

and run the program with

```
ruby set.rb
```

### How to play Set

The rules of the game can be found on [Wikipedia](https://en.wikipedia.org/wiki/Set_(card_game)). Be sure to familiarize yourself with them.

When you first run the game you will be prompted to choose a difficulty. There are three options: Untimed, Timed (Easy) where you will have 45 seconds to find a set, and Timed (Hard) where you will have 15 seconds to find a set.

After choosing your difficulty, twelve cards will be dealt and printed to the terminal. You can then type '1' to enter a set or '2' to redeal the cards.
If you choose to enter a set, enter your cards one by one. If you choose to deal more cards, 12 new cards will be dealt and the new hand will be displayed.
After you enter a set, or if you run out of time in the timed mode, you can type 'y' to play again or 'n' to quit. If the set you entered was a valid set, you will be prompted for the name of the player that found the set. If you quit, the number of sets each player found will be displayed.
