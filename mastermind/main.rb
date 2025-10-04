# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/guesser'

def play_game
  my_game = GameBoard.new
  my_guesser = Guesser.new

  start_gameloop(my_game, my_guesser)
end

def start_gameloop(my_game, my_guesser)
  puts "Valid colors are #{my_game.colors_available.join(', ')} seperated by commas.\n\n"
  until my_game.game_won || my_game.game_lost || my_game.game_quit
    puts "You have #{my_game.remaining_guesses} guesses left."
    colors = my_guesser.retrieve_guess_input(my_game.colors_available)
    feedback = my_game.evaluate_guess(colors)
    print_round_result(feedback, my_game)
  end
end

def print_round_result(results, my_game)
  if my_game.game_quit
    puts 'You quit the game'
  else
    puts "#{results[0]} perfect, #{results[1]} included, #{results[2]} wrong.\n\n"
  end
  puts 'You have won the game by entering the correct code.' if my_game.game_won
  puts 'You have lost the game by running out of guesses.' if my_game.game_lost
end

play_game
