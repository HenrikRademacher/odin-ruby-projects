# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/guesser'
require_relative 'lib/greenwell_guess'

def play_game
  my_game = GameBoard.new
  my_guesser = Guesser.new

  inquire_player_setting(my_game, my_guesser)
end

def testing
  my_game = GameBoard.new
  my_solver = Greenwell.new
  my_game.colors_chosen = %w[r g m m]
  my_solver.commence_guessing(my_game)
end
# testing

def inquire_player_setting(my_game, my_guesser)
  input = -1
  while input != 0 && input != 1
    puts 'Do you want to guess (enter 0) or set the code (enter 1)?'
    input = gets.chomp.to_i
  end
  if input.zero?
    start_humanloop(my_game, my_guesser)
  else
    start_machineloop(my_game, my_guesser)
  end
end

def start_humanloop(my_game, my_guesser)
  puts "\nGame commencing, Computer has picked a code!"
  puts "Valid colors are #{my_game.colors_available.join(', ')} seperated by commas.\n\n"
  until my_game.game_won || my_game.game_lost || my_game.game_quit
    puts "You have #{my_game.remaining_guesses} guesses left."
    colors = my_guesser.retrieve_guess_input(my_game.colors_available)
    feedback = my_game.evaluate_guess(colors)
    print_round_result(feedback, my_game)
  end
end

def start_machineloop(my_game, _my_guesser)
  puts "Please select a code.\nValid colors are #{my_game.colors_available.join(', ')} seperated by commas.\n\n"
  my_game.colors_chosen = retrieve_guess_input(my_game.colors_available)
  solver = -1
  while solver != 0 && solver != 1 && solver != 2
    puts "\n\nDo you want to play against Greenwell (0), Randy (1) or Knuth (2) ?"
    solver = gets.chomp
  end
  assign_enemy(solver, my_game)
end

def assign_enemy(number, my_game)
  case number
  when 0
    my_solver = Greenwell.new
  when 1
    my_solver = Randy.new
  when 2
    my_solver = Knuth.new
  end
  my_solver.commence_guessing(my_game)
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
