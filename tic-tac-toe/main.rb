# frozen_string_literal: true

require_relative 'lib/board'

def play_tictactoe
  player_choice = select_shape.upcase
  computer_choice = (%w[O X] - player_choice.split).join
  puts "You have chosen #{player_choice}"
  puts "Computer plays as #{computer_choice}"
  puts 'These are the coordinates:'
  my_game = Playboard.new
  my_game.print_to_console(my_game.coordinates)
  if computer_choice == 'X'
    my_game.place_cross('B1')
    puts 'The board now looks like this:'
    my_game.print_to_console(my_game.content)
  end
  until my_game.empty_cells.zero? || my_game.game_won == true
    my_game.place_circle(my_game.get_player_coords) if player_choice == 'O'
    my_game.place_cross(my_game.get_player_coords) if player_choice == 'X'
    my_game.check_winner(my_game.content)
    puts 'The board now looks like this:'
    my_game.print_to_console(my_game.content)
    break if my_game.empty_cells.zero? || my_game.game_won == true

    if computer_choice == 'O'
      my_game.place_circle(my_game.get_computer_coords(my_game.content, computer_choice,
                                                       player_choice))
    end
    if computer_choice == 'X'
      my_game.place_cross(my_game.get_computer_coords(my_game.content, computer_choice,
                                                      player_choice))
    end
    puts 'The board now looks like this:'
    my_game.print_to_console(my_game.content)
    my_game.check_winner(my_game.content)
  end
  my_game.display_winner(my_game.check_winner(my_game.content))
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
