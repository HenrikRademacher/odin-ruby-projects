# frozen_string_literal: true

# The Fibonacci Sequence, is a numerical sequence where each number is the sum of the two numbers before it.
# Eg. 0, 1, 1, 2, 3, 5, 8, 13 are the first eight digits in the sequence.

def fibonacci_it(number)
  return [0] if number == 1
  return [0, 1] if number == 2

  i = 2
  new_array = [0, 1]
  until i == number
    new_array.push(new_array[-1] + new_array[-2])
    i += 1
  end
  new_array
end

# p fibonacci_it(1)
# p fibonacci_it(2)
# p fibonacci_it(8)
# p fibonacci_it(16)

def fibonacci_calc(number)
  return 0 if number == 1
  return 1 if number == 2

  fibonacci_calc(number - 1) + fibonacci_calc(number - 2)
end

def fibonacci_rec(number)
  # this is shamelessly stolen, i could not figure out how to recursively return an array
  # apparently you dont and just reassign in everytime
  return my_array = [0] if number == 1
  return my_array = [0, 1] if number == 2

  my_array = fibonacci_rec(number - 1)
  my_array.push(my_array[-2] + my_array[-1])
end

p fibonacci_rec(1)
p fibonacci_rec(2)
p fibonacci_rec(3)
p fibonacci_rec(8)
# p fibonacci_rec(16)
