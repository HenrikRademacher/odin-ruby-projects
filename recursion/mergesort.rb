# frozen_string_literal: true

# input of [3, 2, 1, 13, 8, 5, 0, 1] should return [0, 1, 1, 2, 3, 5, 8, 13]

# erhalte ein oder (optional) zwei Arrays
def merge_sort(my_array) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
  # falls array 1 item enthält, zurückgeben
  return my_array if my_array.count == 1

  # falls array 2 items enthält, teilarray1 aus erster hälfte und teilarray2 aus zweiter hälfte erstellen
  mid = (my_array.count / 2.0).floor
  split1 = my_array.slice(0, mid)
  split2 = my_array.slice(mid, my_array.count)
  # das rekursiv machen, solange arrays 2 oder mehr items enthalten
  sorted_first = merge_sort(split1)
  sorted_second = merge_sort(split2)
  # dann die beiden entstandenen arrays mergen
  #   -> vorderste Items vergleichen, größeren an neues Array pushen und vom alten Array entfernen
  new_array = []
  until sorted_first.count.zero? || sorted_second.count.zero?
    new_array << if sorted_first[0] < sorted_second[0]
                   sorted_first.slice!(0)
                 else
                   sorted_second.slice!(0)
                 end
  end
  new_array << sorted_first.slice!(0) until sorted_first.count.zero?
  new_array << sorted_second.slice!(0) until sorted_second.count.zero?
  # neuen gemergtes Array zurückgeben
  new_array
end

p merge_sort([5])
p merge_sort([8, 5])
p merge_sort([8, 7, 10])
p merge_sort([3, 2, 1, 13])
p merge_sort([3, 2, 1, 13, 8, 5, 0, 1])
