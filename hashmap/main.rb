# frozen_string_literal: true

require_relative 'lib/mashmap'
require_relative 'lib/hashset'
require_relative 'lib/node'

test = Hashmap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple') # 11
test.set('hat', 'black') # 11
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
p test.entries
