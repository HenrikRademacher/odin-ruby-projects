# frozen_string_literal: true

# either computer or human guessing the set code
class Guesser
  attr_accessor :remaining_guesses

  def initialize
    @guess_history = []
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
