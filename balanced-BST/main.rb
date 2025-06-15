# frozen_string_literal: true

require_relative 'lib/unbalanced_tree'
require_relative 'lib/balanced_tree'
require_relative 'lib/node'
require_relative 'lib/balanced_node'

source_array = [33, 3, 90, 7, 33, 45, 10, 8, 1, 40, 50, 60, 42, 57]
p source_array

my_tree = BST.new
my_tree.populate(source_array)

sorted_array = my_tree.inorder_traverse
p sorted_array
puts('')

my_baltree = BBST.new
my_baltree.populate(sorted_array)
my_baltree.insert(75)
my_baltree.insert(33)
my_baltree.pretty_print
puts('')
my_baltree.delete(40)
my_baltree.pretty_print

puts('')
my_baltree.insert(40)
my_baltree.pretty_print

p my_baltree.find(42).amount
