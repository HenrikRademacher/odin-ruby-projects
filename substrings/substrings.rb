def substrings(string, dictarray)
  output = Hash.new(0)
  dictarray.each do |current|
    string = string.downcase
    current = current.downcase
    output[current] = (string.length - string.gsub(current, "").length) / current.length unless string.downcase[current.downcase] == nil
  end
  return output
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)