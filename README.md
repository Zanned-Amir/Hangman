# Hangman Game

Hangman Game is a simple console-based Hangman game written in Ruby. The game randomly selects a word from a list of English words, and the player has to guess the word by suggesting letters. The game also supports saving and loading progress.

## Features

- Randomly selects a word for the player to guess.
- Displays a hangman graphic based on the number of incorrect guesses.
- Supports saving and loading game progress.
- Simple console-based user interface.

## Getting Started

To get started with the Hangman Game, follow these steps:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/hangman-game.git
   cd hangman-gam
2. Run the Game:
- Execute the following command to start the game:
  ```bash
  ruby hangman_game.rb
3. Follow On-screen Instructions:
The game will prompt you to enter characters to guess the word.
Follow the on-screen instructions to play.

## How to Play
 - Guess the word by entering characters one at a time.
 - Incorrect guesses will result in the display of a hangman graphic.
 - You have a limited number of chances to guess the word.
 - Save your progress during the game and resume later.
 - Save and Load
 - When prompted, you can choose to save your progress and leave the game.
 - To resume a saved game, select the option to restart and choose the saved game file.
## File Structure
 - hangman_game.rb: Main Ruby script containing the game logic.
 - google-10000-english-no-swears.txt: Text file containing a list of English words.
 - save.json: JSON file used to store save game data.
