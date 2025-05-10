def create_cipher(input_string, shift_value)
  input_array = input_string.bytes
  output_array = input_array.map do |byte_value|
    resolve_item(byte_value, shift_value)
  end
  output_array.join
end

def resolve_item(single_byte, shift_value)
  if single_byte.between?(65, 90)
    single_byte += shift_value
    single_byte -= 26 if single_byte > 90
  elsif single_byte.between?(97, 122)
    single_byte += shift_value
    single_byte -= 26 if single_byte > 122
  end
  single_byte.chr
end

puts create_cipher('ABCZ abcz', 3)
puts create_cipher('What a string!', 5)
# ascii:
# uppercase A is 65
# uppercase Z is 90
# lowercase a is 97
# lowercase z is 122
# .byte transforms letter to ascii value
# .chr transforms ascii value to letter
