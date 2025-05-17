# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/guesser'

def play_game
  my_game = GameBoard.new
  my_guesser = Guesser.new
  start_gameloop(my_game, my_guesser)
end

def start_gameloop(my_game, my_guesser)
  game_won = false
  game_lost = false
  puts "Valid colors are #{my_game.colors_available.join(', ')} seperated by commas."
  until game_won || game_lost
    puts ''
    puts "You have #{my_guesser.remaining_guesses} guesses left."
    colors = my_guesser.make_guess(my_game.colors_available)
    feedback = my_game.evaluate_guess(colors)
    puts feedback
    if feedback[0] == '4'
      puts 'You have won the game by entering the correct code.'
      game_won = true
    elsif my_guesser.remaining_guesses.zero?
      puts 'You have lost the game by running out of guesses.'
      game_lost = true
    end
  end
end

play_game
