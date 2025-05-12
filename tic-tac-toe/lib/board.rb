# frozen_string_literal: true

# Board for Tic-Tac-Toe game
class Playboard
  attr_accessor :content
  attr_reader :empty_cells, :game_increment, :coordinates, :game_won

  @@game_increment = 0 # rubocop:disable Style/ClassVars

  def initialize
    @empty_cells = 9
    @game_won = false
    @content = Array.new(3) { Array.new(3, '_') }
    @coordinates = [%w[A1 A2 A3], %w[B1 B2 B3], %w[C1 C2 C3]]
    @@game_increment += 1 # rubocop:disable Style/ClassVars
  end

  def print_to_console(input_array)
    input_array.each do |row_array|
      p row_array.join(' ')
    end
  end

  def check_winner(input_array)
    combo_array = get_combinations(input_array)
    if combo_array.include?('XXX')
      @game_won = true
      'cross'
    elsif combo_array.include?('OOO')
      @game_won = true
      'circle'
    end
  end

  def get_combinations(input_array)
    combos = []
    combos[0] = input_array[0][0] + input_array[0][1] + input_array[0][2]
    combos[1] = input_array[1][0] + input_array[1][1] + input_array[1][2]
    combos[2] = input_array[2][0] + input_array[2][1] + input_array[2][2]
    combos[3] = input_array[0][0] + input_array[1][0] + input_array[2][0]
    combos[4] = input_array[0][1] + input_array[1][1] + input_array[2][1]
    combos[5] = input_array[0][2] + input_array[1][2] + input_array[2][2]
    combos[6] = input_array[0][0] + input_array[1][1] + input_array[2][2]
    combos[7] = input_array[2][0] + input_array[1][1] + input_array[0][2]
    combos
  end

  def get_computer_coords(input_array, computer_choice, player_choice)
    if input_array[1][1] == '_'
      # middle is still empty
      puts 'The computer picked B2.'
      'B2'
    else
      combo_array = get_combinations(input_array)
      own_clinch = -1
      enemy_clinch = -1
      combo_array.each_with_index do |combination, index|
        if combination.split('').count(computer_choice) == 2
          own_clinch = index
        elsif combination.split('').count(player_choice) == 2
          enemy_clinch = index
        end
      end
      select_col = enemy_clinch if enemy_clinch > -1
      select_col = own_clinch if own_clinch > -1
      select_row = combo_array[select_col].split('').index('_')
      name = %w[A B C][select_row]
      name += (select_col + 1).to_s
      puts "The computer picked #{name}."
      name
    end
  end

  def place_circle(coordinate)
    column = coordinate[1].to_i - 1
    row = coordinate[0].bytes.join.to_i - 65
    content[row][column] = 'O'
  end

  def place_cross(coordinate)
    column = coordinate[1].to_i - 1
    row = coordinate[0].bytes.join.to_i - 65
    content[row][column] = 'X'
  end

  def slot_available?(coordinate)
    column = coordinate[1].to_i - 1
    row = coordinate[0].bytes.join.to_i - 65
    content[row][column] == '_'
  end

  def out_of_bounds?(coordinate)
    return true unless coordinate.instance_of?(String)
    return true unless coordinate.length == 2
    return true unless coordinate[0].instance_of?(Integer)
    return true unless [1, 2, 3].include?(coordinate[0])
    return true unless coordinate[1].instance_of?(String)
    return true unless %w[A B C].include?(coordinate[1])

    false
  end

  def get_player_coords
    entry = ''
    until %w[A1 A2 A3 B1 B2 B3 C1 C2 C3].include?(entry)
      puts 'Pick a Coordinate for your shape.'
      entry = gets.chomp
    end
    entry
  end
end

my_board = Playboard.new
my_board.print_to_console(my_board.coordinates)
my_board.place_cross('A2')
my_board.place_cross('A3')
my_board.place_circle('B1')
my_board.place_circle('B2')
my_board.print_to_console(my_board.content)
my_board.place_circle(my_board.get_computer_coords(my_board.content, 'O', 'X'))
my_board.print_to_console(my_board.content)
p my_board.check_winner(my_board.content)
