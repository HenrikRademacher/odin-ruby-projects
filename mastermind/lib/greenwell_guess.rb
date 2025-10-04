# frozen_string_literal: true

require_relative 'solvable'

# solving in 7 steps
class Greenwell
  include Solvable

  def initialize
    @combination_total = []
    @combination_possible = []
    @my_colors = []
    @my_steps = []
  end

  def commence_guessing(my_game)
    @combination_total = create_combinations(my_game.colors_available)
    @my_colors = my_game.colors_available
    create_guessing_steps
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
end
