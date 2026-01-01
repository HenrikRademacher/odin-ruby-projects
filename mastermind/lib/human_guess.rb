# frozen_string_literal: true

# either computer or human guessing the set code
class Human
  attr_accessor :remaining_guesses

  def initialize
    @guess_history = []
  end

  def start_gameloop(my_game)
    puts "\nGame commencing, Computer has picked a code!"
    puts "Valid colors are #{my_game.colors_available.join(', ')} seperated by commas.\n\n"
    until my_game.game_won || my_game.game_lost || my_game.game_quit
      puts "You have #{my_game.remaining_guesses} guesses left."
      colors = retrieve_guess_input(my_game.colors_available)
      feedback = my_game.evaluate_guess(colors)
      my_game.print_round_result(feedback)
    end
  end

  def retrieve_guess_input(colors_available)
    valid_answer = false
    until valid_answer == true
      puts 'Please provide a valid combination.'
      answer = gets.chomp.downcase.gsub(' ', '').split(',')
      valid_answer = true if answer.instance_of?(Array) && answer.length == 4 && answer.all? do |color|
        colors_available.include?(color)
      end
      valid_answer = true if answer[0] == 'exit'
    end
    answer
  end
end
