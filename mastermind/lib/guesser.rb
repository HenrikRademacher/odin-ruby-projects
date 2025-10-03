# frozen_string_literal: true

# either computer or human guessing the set code
class Guesser
  attr_accessor :remaining_guesses

  def initialize
    @remaining_guesses = 12
    @guess_history = []
  end

  def make_guess(colors_available)
    guess = retrieve_guess_input(colors_available)
    @remaining_guesses -= 1
    guess
  end

  def retrieve_guess_input(colors_available)
    valid_answer = ''
    until valid_answer != ''
      puts 'Please provide a valid combination.'
      answer = gets.chomp.downcase.gsub(' ', '').split(',')
      valid_answer = answer
      valid_answer = '' unless answer.instance_of?(Array)
      valid_answer = '' unless answer.length == 4
      valid_answer = '' unless answer.all? { |color| colors_available.include?(color) }
      valid_answer = answer[0] if answer[0] == 'exit'
    end
    valid_answer
  end
end
