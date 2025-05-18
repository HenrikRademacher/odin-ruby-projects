# frozen_string_literal: true

# Gameboard for Hangman
class Hangman
  attr_reader :game_won, :game_lost

  def initialize
    @remaining_guesses = 8
    @chosen_word = choose_word.split('')
    @remaining_slots = @chosen_word.length + 1
    @guess_status = Array.new(@remaining_slots - 1, '_')
    @game_won = false
    @game_lost = false
    @struck_letters = []
  end

  def choose_word
    word = ''
    File.open('files/dictionary.txt', 'r') do |dictionary|
      dictionary_list = dictionary.readlines
      word = dictionary_list.sample.downcase until word.length > 4 && word.length < 13
    end
    word.chomp
  end

  def resolve_guess(letter)
    if @chosen_word.include?(letter)
      print_letter(letter)
    else
      @remaining_guesses -= 1
      check_loser
    end
    @struck_letters.push(letter.upcase)
    provide_game_info
  end

  def resolve_word(word)
    if @chosen_word.join('') == word
      @game_won = true
      check_winner
    else
      @remaining_guesses -= 1
      check_loser
    end
    provide_game_info
  end

  def print_letter(letter)
    @chosen_word.length.times do |index|
      @guess_status[index] = @chosen_word[index] if @chosen_word[index] == letter
    end
    refresh_remaining
  end

  def refresh_remaining
    @remaining_slots = @guess_status.count('_')
    check_winner
  end

  def check_winner
    @game_won = true if @remaining_slots.zero?
  end

  def check_loser
    @game_lost = true if @remaining_guesses.zero?
  end

  def provide_loss_info
    return unless @game_lost

    puts 'You lost the game by running out of tries.'
    puts "The chosen word was #{@chosen_word.join('').capitalize}."
    puts ''
  end

  def provide_win_info
    return unless @game_won

    puts 'Congratulations, you won the game!'
    puts "You correctly identified #{@chosen_word.join('').capitalize}."
    puts ''
  end

  def provide_game_info
    puts "#{@guess_status.join(' ')} - you have #{@remaining_guesses} guesses left."
    puts "used letters: #{@struck_letters.sort.join('')}" unless @struck_letters.empty?
  end

  def create_savegame
    serialized = Marshal.dump(self)
    File.write('files/savegame.txt', serialized)
  end
end
