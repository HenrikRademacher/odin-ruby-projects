# frozen_string_literal: true

require_relative 'lib/hashmap'
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

p test.length
test.set('jacket', 'yellow')
test.set('hat', 'white')
p test.length

test.set('moon', 'silver')
p test.length

test.set('carrot', 'moldy')
test.set('moon', 'bloodred')
p test.length

p test.keys
p test.values
p test.entries

test.remove('carrot')
test.remove('frog')
test.remove('sky')
test.remove('dog')
test.remove('elephant')
test.remove('banana')
p test.entries

my_hashset = Hashset.new
my_hashset.set('August')
my_hashset.set('July')
my_hashset.set('November')
my_hashset.set('January')
my_hashset.set('July')
my_hashset.set('December')
p my_hashset.get('July')
