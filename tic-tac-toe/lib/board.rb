class Playboard
  attr_accessor :content
  attr_reader :empty_cells, :coordinates, :game_won

  def initialize
    @empty_cells = 9
    @game_won = false
    @content = Array.new(3) { Array.new(3, '_') }
    @coordinates = [%w[A1 A2 A3], %w[B1 B2 B3], %w[C1 C2 C3]]
  end

  def print_to_console(input_array)
    input_array.each do |row_array|
      p row_array.join(' ')
    end
  end

  def check_winner
    combo_array = get_combinations
    if combo_array.include?('XXX')
      @game_won = true
      'cross'
    elsif combo_array.include?('OOO')
      @game_won = true
      'circle'
    end
  end

  def get_combinations
    combos = []
    combos[0] = content[0][0] + content[0][1] + content[0][2]
    combos[1] = content[1][0] + content[1][1] + content[1][2]
    combos[2] = content[2][0] + content[2][1] + content[2][2]
    combos[3] = content[0][0] + content[1][0] + content[2][0]
    combos[4] = content[0][1] + content[1][1] + content[2][1]
    combos[5] = content[0][2] + content[1][2] + content[2][2]
    combos[6] = content[0][0] + content[1][1] + content[2][2]
    combos[7] = content[2][0] + content[1][1] + content[0][2]
    combos
  end

  def get_computer_coords(computer_choice, player_choice)
    if content[1][1] == '_'
      puts 'The computer picked B2.'
      'B2'
    else
      combo_array = get_combinations
      reference_array = [%w[A1 A2 A3], %w[B1 B2 B3], %w[C1 C2 C3], %w[A1 B1 C1], %w[A2 B2 C2], %w[A3 B3 C3],
                         %w[A1 B2 C3], %w[C1 B2 A3]]
      own_clinch = -1
      enemy_clinch = -1
      combo_array.each_with_index do |combination, index|
        if combination.split('').count(computer_choice) == 2 && combination.split('').count('_') == 1
          own_clinch = index
        elsif combination.split('').count(player_choice) == 2 && combination.split('').count('_') == 1
          enemy_clinch = index
        end
      end
      select_combo = -1
      select_combo = enemy_clinch if enemy_clinch > -1
      select_combo = own_clinch if own_clinch > -1
      return_coord = if select_combo > -1
                       reference_array[select_combo][combo_array[select_combo].split('').index('_')]
                     else
                       random_free_coord
                     end
      puts "The computer picked #{return_coord}."
      return_coord
    end
  end

  def random_free_coord
    my_slots = %w[A1 A2 A3 B1 B2 B3 C1 C2 C3].shuffle
    until slot_available?(my_slots[0])
      my_slots.slice!(0)
      my_slots.shuffle
    end
    my_slots[0]
  end

  def place_shape(coordinate, shape)
    column = coordinate[1].to_i - 1
    row = coordinate[0].bytes.join.to_i - 65
    content[row][column] = shape
    @empty_cells -= 1
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
    until entry != ''
      puts 'Pick a Coordinate for your shape.'
      entry = gets.chomp
      entry = '' unless %w[A1 A2 A3 B1 B2 B3 C1 C2 C3].include?(entry)
      entry = '' unless slot_available?(entry)
    end
    entry
  end
end

# my_board = Playboard.new
# my_board.print_to_console(my_board.coordinates)
# my_board.place_shape('A1', 'O')
# my_board.place_shape('A2', 'O')
# my_board.place_shape('A3', 'X')
# my_board.place_shape('B2', 'X')
# my_board.place_shape('C2', 'X')
# my_board.print_to_console(my_board.content)
# my_board.place_shape(my_board.get_computer_coords('O', 'X'), 'O')
# my_board.print_to_console(my_board.content)
# p my_board.check_winner
