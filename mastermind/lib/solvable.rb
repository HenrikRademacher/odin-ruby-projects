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
