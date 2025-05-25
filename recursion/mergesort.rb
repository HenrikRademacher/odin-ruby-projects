# frozen_string_literal: true

# input of [3, 2, 1, 13, 8, 5, 0, 1] should return [0, 1, 1, 2, 3, 5, 8, 13]

def merge_rec(array)
  return array if array.length == 1

  return unless array.length == 2
  return array if array[0] < array[1]

  array.reverse
end
