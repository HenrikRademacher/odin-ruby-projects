def bubblesort(input_array)
  switched = true
  while switched
    switched = false
    i = 0
    while i < (input_array.length) -1
      if input_array[i] > input_array[i+1]
        temp = input_array[i]
        input_array[i] = input_array[i+1]
        input_array[i+1] = temp
        switched = true
      end
      i = i + 1
    end
  end
  return input_array
end

unsorted = [8,13,0,65,-3,15,15,33]
p bubblesort(unsorted)
unsorted = [4,3,78,2,0,2]
p bubblesort(unsorted)