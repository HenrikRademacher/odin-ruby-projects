# frozen_string_literal: true

require_relative 'lib/board'

def play_tictactoe
  player_choice = select_shape.upcase
  my_game = Playboard.new
  if player_choice == 'X'
    computer_choice = 'O'
    active_turn = 'human'
  else
    computer_choice = 'X'
    active_turn = 'computer'
  end
  puts "You have chosen #{player_choice}"
  puts "Computer plays as #{computer_choice}"
  puts 'These are the coordinates:'
  my_game.print_to_console(my_game.coordinates)
  until my_game.empty_cells.zero? || my_game.game_won == true
    puts ''
    if active_turn == 'computer'
      puts 'Calculating computer choice.'
      my_game.place_shape(my_game.get_computer_coords(computer_choice, player_choice), computer_choice)
    else
      puts 'Awaiting player choice.'
      my_game.place_shape(my_game.get_player_coords, player_choice)
    end
    active_turn = (%w[computer human] - active_turn.split).join
    my_game.check_winner
    puts 'The board now looks like this:'
    my_game.print_to_console(my_game.content)
  end
  if my_game.game_won
    p "#{my_game.check_winner} has clinched the game."
  else
    p 'Game over without winners. Please restart.'
  end
end

def select_shape
  player_shape = ''
  until %w[X O x o].include?(player_shape)
    puts 'Choose X or O as your shape. X begins.'
    player_shape = gets.chomp
  end
  player_shape
end

play_tictactoe
