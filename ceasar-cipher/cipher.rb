def create_cipher(input_string, shift_value)
  input_array = input_string.bytes
  output_array = input_array.map { |byte_value|
    if byte_value.between?(65,90)
      byte_value += shift_value
      byte_value -= 26 if byte_value > 90
    elsif byte_value.between?(97,122)
      byte_value += shift_value
      byte_value -= 26 if byte_value > 122
    end
    byte_value = byte_value.chr
  }
  return output_array.join()
end
puts create_cipher("ABCZ abcz", 3)
puts create_cipher("What a string!", 5)
# ascii: 
# uppercase A is 65
# uppercase Z is 90 
# lowercase a is 97
# lowercase z is 122
# .byte transforms letter to ascii value
# .chr transforms ascii value to letter