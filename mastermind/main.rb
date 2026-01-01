# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/human_guess'
require_relative 'lib/greenwell_guess'

def play_game
  my_game = GameBoard.new

  inquire_player_setting(my_game)
end

def testing
  my_game = GameBoard.new
  my_solver = Greenwell.new
  my_game.colors_chosen = %w[r g m m]
  my_solver.commence_guessing(my_game)
end
# testing

def inquire_player_setting(my_game)
  input = -1
  while input != 0 && input != 1
    puts 'Do you want to guess (enter 0) or set the code (enter 1)?'
    input = gets.chomp.to_i
  end
  assign_guesser(my_game, input)
end

def assign_guesser(my_game, input)
  my_guesser = if input.zero?
                 Human.new
               else
                 choose_enemy(my_game)
               end
  my_guesser.start_gameloop(my_game)
end

def choose_enemy(my_game)
  puts "Please select a code.\nValid colors are #{my_game.colors_available.join(', ')} seperated by commas.\n\n"
  my_game.select_colors_human
  answer = -1
  while answer != 0 && answer != 1 && answer != 2
    puts "\nDo you want to play against Greenwell (0), Randy (1) or Knuth (2) ?"
    answer = gets.chomp.to_i
  end
  assign_enemy(answer)
end

def assign_enemy(number)
  case number
  when 0
    my_solver = Greenwell.new
  when 1
    my_solver = Randy.new
  when 2
    my_solver = Knuth.new
  end
  my_solver
end

play_game
