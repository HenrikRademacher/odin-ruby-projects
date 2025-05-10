# frozen_string_literal: true

# Board for Tic-Tac-Toe game
class Playboard
  attr_accessor :content
  attr_reader :empty_cells

  def initialize
    @empty_cells = 9
    @content = Array.new(3) { Array.new(3, '_') }
  end

  def print_to_console(input_array)
    input_array.each do |row_array|
      p row_array.join(' ')
    end
  end
end

my_board = Playboard.new
my_board.print_to_console(my_board.content)
