# frozen_string_literal: true

# Creates the gameboard and its methods
class GameBoard
  attr_reader :colors_available, :game_won, :game_lost, :game_quit, :remaining_guesses

  def initialize
    @colors_available = %w[r g b m y c]
    @colors_chosen = select_colors
    @game_won = false
    @game_lost = false
    @game_quit = false
    @remaining_guesses = 12
  end

  def select_colors
    output = []
    4.times do
      output.push(@colors_available.sample)
    end
    # p "Computer chose #{output}" ## hier kommentieren, um Druck der Computer-Wahl zu verhindern
    output
  end

  def evaluate_guess(selection)
    perfect_count, rest_selection, rest_colors = count_perfect_guess(selection, @colors_chosen)
    included_count = count_include_guess(rest_selection, rest_colors)
    wrong_count = selection.length - perfect_count - included_count
    set_guess_consequences(perfect_count, selection)
    [perfect_count, included_count, wrong_count]
  end

  def set_guess_consequences(perfect, guesses)
    @remaining_guesses -= 1
    @game_won = true if perfect == 4
    @game_lost = true if @remaining_guesses.zero? && @game_won.false?
    puts @colors_chosen if @game_lost
    @game_quit = true if guesses[0] == 'exit'
  end

  def count_perfect_guess(color_guess, colors_chosen, rest_selection = [], rest_colors = [])
    perfect_count = 0
    color_guess.each_with_index do |guess, index|
      if guess == colors_chosen[index]
        perfect_count += 1
      else
        rest_selection << guess
        rest_colors << colors_chosen[index]
      end
    end
    [perfect_count, rest_selection, rest_colors]
  end

  def count_include_guess(rest_selection, rest_colors)
    include_guess = 0
    rest_selection.each do |guess|
      if rest_colors.include?(guess)
        include_guess += 1
        rest_colors.delete_at(rest_colors.index(guess))
      end
    end
    include_guess
  end
end
