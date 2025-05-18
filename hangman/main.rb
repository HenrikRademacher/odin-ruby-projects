# frozen_string_literal: true

require_relative 'lib/hangman'

def resolve_input(my_game)
  puts ''
  puts 'Awaiting user input'
  input = gets.chomp.downcase
  my_game.create_savegame if input == 'save'
  exit if input == 'exit'
  my_game.resolve_guess(input) if input.length == 1 && input.instance_of?(String)
  my_game.resolve_word(input) if input.length > 1 && input.instance_of?(String)
end

def play_game(my_game)
  my_game.provide_game_info
  resolve_input(my_game) until my_game.game_won || my_game.game_lost
  my_game.provide_win_info if my_game.game_won
  my_game.provide_loss_info if my_game.game_lost
end

def start_game
  loading_wanted = ask_load_game if File.exist?('files/savegame.txt')
  my_game = if loading_wanted
              retrieve_savegame
            else
              Hangman.new
            end
  play_game(my_game)
end

def retrieve_savegame
  File.open('files/savegame.txt', 'r') do |file|
    serialized = file.readlines.join('')
    Marshal.load(serialized)
  end
end

def ask_load_game
  puts 'Savefile detected. Load previous? y/n'
  answer = gets.chomp.downcase
  File.delete('files/savegame.txt') if answer == 'n'
  true if answer == 'y'
end

start_game
