# frozen_string_literal: true

require_relative 'solvable'

# solving in 7 steps
class Greenwell
  include Solvable

  def initialize
    @combination_possible = []
    @my_colors = []
    @my_steps = []
  end

  def start_gameloop(my_game)
    @combination_possible = create_combinations(my_game.colors_available)
    @my_colors = my_game.colors_available
    create_guessing_steps
    play_game(my_game)
  end

  def create_guessing_steps
    create_step1
    create_step2
    create_step3
    create_step4
    create_step5
    create_step6
  end

  def create_step1
    @my_steps << [@my_colors[0], @my_colors[1], @my_colors[1], @my_colors[0]]
  end

  def create_step2
    @my_steps << [@my_colors[1], @my_colors[2], @my_colors[4], @my_colors[3]]
  end

  def create_step3
    @my_steps << [@my_colors[2], @my_colors[2], @my_colors[0], @my_colors[0]]
  end

  def create_step4
    @my_steps << [@my_colors[3], @my_colors[4], @my_colors[1], @my_colors[3]]
  end

  def create_step5
    @my_steps << [@my_colors[4], @my_colors[5], @my_colors[4], @my_colors[5]]
  end

  def create_step6
    @my_steps << [@my_colors[5], @my_colors[5], @my_colors[3], @my_colors[2]]
  end

  def play_game(my_game)
    @my_steps.each do |step|
      break if my_game.game_won == true || my_game.game_lost == true || @combination_possible.count == 1

      puts "Greenwell tries combination #{step.join(',')}"
      feedback = my_game.evaluate_guess(step)
      my_game.print_round_result(feedback)
      resolve_feedback(step, feedback)
    end
    solve_game(my_game)
  end

  def resolve_feedback(step, feedback)
    prev_number = @combination_possible.count
    @combination_possible.keep_if { |element| valid_combination?(step, feedback, element) }
    puts "Eliminated #{prev_number - @combination_possible.count} options, now #{@combination_possible.count} remaining"
  end

  def solve_game(my_game)
    return unless my_game.game_won == false && my_game.game_lost == false

    if @combination_possible.count == 1
      puts "Greenwell found the correct code: #{@combination_possible[0]}"
      feedback = my_game.evaluate_guess(@combination_possible[0])
      my_game.print_round_result(feedback)
    else
      puts 'Greenwell Strategy failed, sorry'
    end
  end
end
