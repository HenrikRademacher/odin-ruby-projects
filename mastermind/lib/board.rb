# frozen_string_literal: true

# Creates the gameboard and its methods
class GameBoard
  attr_reader :colors_available

  def initialize
    @colors_available = %w[red green blue magenta yellow cyan]
    @colors_chosen = select_colors
  end

  def select_colors
    output = []
    4.times do
      output.push(@colors_available.sample)
    end
    p output
    output
  end

  def evaluate_guess(selection)
    perfect_count = 0
    guesses_no_perfect = []
    selection_no_perfect = []
    selection.length.times do |number|
      if selection[number - 1] == @colors_chosen[number - 1]
        perfect_count += 1
      else
        guesses_no_perfect.push(selection[number - 1])
        selection_no_perfect.push(@colors_chosen[number - 1])
      end
    end
    included_count = 0
    guesses_wrong = []
    guesses_no_perfect.length.times do |number|
      if selection_no_perfect.include?(guesses_no_perfect[number - 1])
        included_count += 1
        selection_no_perfect[selection_no_perfect.index(guesses_no_perfect[number - 1])] = ''
      else
        guesses_wrong.push(guesses_no_perfect[number - 1])
      end
    end
    wrong_count = guesses_wrong.length
    "#{perfect_count} perfect, #{included_count} included, #{wrong_count} wrong."
  end
end
