# frozen_string_literal: true

require_relative 'solvable'

# maximising eliminations strategy
class Knuth
  include Solvable

  def initialize
    @combination_total = []
    @combination_possible = []
    @my_colors = []
  end

  def start_gameloop(my_game)
    @combination_total = create_combinations(my_game.colors_available)
    @combination_possible = @combination_total.clone
    @my_colors = my_game.colors_available
    step = [@my_colors[0], @my_colors[0], @my_colors[1], @my_colors[1]]
    puts "Calculations may take a while.\n\nKnuth tries combination #{step.join(',')}"
    feedback = my_game.evaluate_guess(step)
    my_game.print_round_result(feedback)
    resolve_feedback(step, feedback)
    play_game(my_game)
  end

  def play_game(my_game)
    while my_game.remaining_guesses.positive?
      break if my_game.game_won == true || my_game.game_lost == true || @combination_possible.count == 1

      step = find_optimal_step(possible_feedback)
      puts "Knuth tries combination #{step.join(',')}"
      feedback = my_game.evaluate_guess(step)
      my_game.print_round_result(feedback)
      resolve_feedback(step, feedback)
    end
    solve_game(my_game)
  end

  def find_optimal_step(feedback_options)
    current_best = 0
    scores_per_code = @combination_total.map do |code_element|
      lowest_score = lowest_feedback_eliminations(feedback_options, code_element, current_best)
      current_best = [lowest_score, current_best].max
      lowest_score
    end
    @combination_total[scores_per_code.index(scores_per_code.max)]
  end

  def lowest_feedback_eliminations(feedback_options, code_element, current_best)
    last_result = @combination_possible.count
    scores_per_feedback = []
    incr = 0
    while incr <= feedback_options.count - 1 && last_result > current_best
      scores_per_feedback << find_elimination_count(code_element, feedback_options[incr])
      last_result = scores_per_feedback[incr]
      incr += 1
    end
    scores_per_feedback.min
  end

  def find_elimination_count(code_element, feedback_element)
    trial = @combination_possible.clone.keep_if { |step| valid_combination?(code_element, feedback_element, step) }
    @combination_possible.count - trial.count
  end

  def resolve_feedback(step, feedback)
    prev_number = @combination_possible.count
    @combination_possible.keep_if { |element| valid_combination?(step, feedback, element) }
    puts "Eliminated #{prev_number - @combination_possible.count} options, #{@combination_possible.count} remaining"
  end

  def solve_game(my_game)
    return unless my_game.game_won == false && my_game.game_lost == false

    if @combination_possible.count == 1
      puts "Knuth found the correct code: #{@combination_possible[0]}"
      feedback = my_game.evaluate_guess(@combination_possible[0])
      my_game.print_round_result(feedback)
    else
      puts 'Knuth Strategy failed, sorry'
    end
  end
end
