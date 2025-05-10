# frozen_string_literal: true

# Board for Tic-Tac-Toe game
class Playboard
  attr_accessor :content
  attr_reader :empty_cells, :game_increment, :coordinates

  @@game_increment = 0 # rubocop:disable Style/ClassVars

  def initialize
    @empty_cells = 9
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
      'cross'
    elsif combo_array.include?('OOO')
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

  def inside_of_bounds?(coordinate)
    return false unless coordinate.instance_of?(String)
    return false unless coordinate.length == 2
    return false unless coordinate[0].instance_of?(Integer)
    return false unless [1, 2, 3].include?(coordinate[0])
    return false unless coordinate[1].instance_of?(String)
    return false unless %w[A B C].include?(coordinate[1])

    true
  end
end

my_board = Playboard.new
my_board.place_circle('A1')
my_board.place_cross('A2')
my_board.place_cross('A3')
my_board.place_circle('B1')
my_board.place_circle('B2')
my_board.place_circle('B3')
my_board.print_to_console(my_board.content)
p my_board.check_winner(my_board.content)
