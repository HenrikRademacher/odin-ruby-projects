# frozen_string_literal: true

require_relative 'solvable'

# solving in 7 steps
class Randy
  include Solvable

  def initialize
    @combination_possible = []
    @my_colors = []
  end

  def start_gameloop(my_game)
    @combination_possible = create_combinations(my_game.colors_available)
    @my_colors = my_game.colors_available
    play_game(my_game)
  end

  def play_game(my_game)
    while my_game.remaining_guesses.positive?
      break if my_game.game_won == true || my_game.game_lost == true || @combination_possible.count == 1

      step = @combination_possible.sample
      puts "Randy tries combination #{step.join(',')}"
      feedback = my_game.evaluate_guess(step)
      my_game.print_round_result(feedback)
      resolve_feedback(step, feedback)
    end
    solve_game(my_game)
  end

  def resolve_feedback(step, feedback)
    prev_number = @combination_possible.count
    @combination_possible.keep_if { |element| valid_combination?(step, feedback, element) }
    puts "Eliminated #{prev_number - @combination_possible.count} options, #{@combination_possible.count} remaining"
  end

  def solve_game(my_game)
    return unless my_game.game_won == false && my_game.game_lost == false

    if @combination_possible.count == 1
      puts "Randy found the correct code: #{@combination_possible[0]}"
      feedback = my_game.evaluate_guess(@combination_possible[0])
      my_game.print_round_result(feedback)
    else
      puts 'Randy Strategy failed, sorry'
    end
  end
end
