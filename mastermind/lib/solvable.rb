# frozen_string_literal: true

# generalized code treatment for solving
module Solvable
  def create_combinations(possible_guesses, list = [])
    possible_guesses.each do |element1|
      possible_guesses.each do |element2|
        possible_guesses.each do |element3|
          possible_guesses.each do |element4|
            list << [element1, element2, element3, element4]
          end
        end
      end
    end
    list
  end

  def valid_combination?(guess, feedback, pretend_correct)
    # If pretend_correct was the right combination, would my guess return the feedback?
    answer = hypthetical_guess(guess, pretend_correct)
    # puts "Pretend: #{pretend_correct}; Try: #{guess}; Get: #{answer}; Expect: #{feedback}; OK: #{answer == feedback}"
    answer == feedback
  end

  def hypthetical_guess(selection, pretend_correct)
    perfect_count, rest_selection, rest_colors = count_perfect_guess(selection, pretend_correct)
    included_count = count_include_guess(rest_selection, rest_colors)
    wrong_count = selection.length - perfect_count - included_count
    [perfect_count, included_count, wrong_count]
  end

  def count_perfect_guess(color_guess, pretend_correct, rest_selection = [], rest_colors = [])
    perfect_count = 0
    color_guess.each_with_index do |guess, index|
      if guess == pretend_correct[index]
        perfect_count += 1
      else
        rest_selection << guess
        rest_colors << pretend_correct[index]
      end
    end
    [perfect_count, rest_selection, rest_colors]
  end

  def count_include_guess(rest_selection, rest_colors)
    include_guess = 0
    rest_selection.each do |guess|
      if rest_colors.include?(guess)
        include_guess += 1
        rest_colors.delete_at(rest_colors.index(guess))
      end
    end
    include_guess
  end

  def possible_feedback(feedback = [])
    feedback.push([0, 0, 4], [0, 1, 3], [0, 2, 2], [0, 3, 1], [0, 4, 0])
    feedback.push([1, 0, 3], [1, 1, 2], [1, 2, 1], [1, 3, 0])
    feedback.push([2, 0, 2], [2, 1, 1], [2, 2, 0])
    feedback.push([3, 0, 1], [3, 1, 0], [4, 0, 0])
    feedback
  end
end

# Strategy:

# 0/0/4
# -> Keine der vier Farben kommt vor, alle mit Vorkommen entfernen

# 4/0/0
# -> Korrekter Code, nur diesen behalten

# 0/1/3 oder 1/0/3
# -> nur einer enthalten
# -> codes ausschließen, die eine kombination aus farben im aktuellen code enthalten
# -> 2 gleiche Farben in Versuch: kann max 1x diese Farbe sein

# --> gar nicht zurückdenken, sondern alle nacheinander ausprobieren und feedback simulieren?
# -> habe immer restliste, probierten code und feedback.
# 1. Fall: nach tatsächlichem Probieren die restliste weiter reduzieren
# 2. Fall: hypotetische Reduzierung für jeden Code und jede Feedbackart.
# Für beide Fälle braucht es nur eine Prüfung, die massenhaft angewendet werde kann.
