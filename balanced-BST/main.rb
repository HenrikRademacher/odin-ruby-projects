# frozen_string_literal: true

require_relative 'lib/unbalanced_tree'
require_relative 'lib/balanced_tree'
require_relative 'lib/node'
require_relative 'lib/balanced_node'

source_array = [37, 3, 90, 7, 33, 45, 10, 8, 1]
p source_array

my_tree = BST.new
my_tree.populate(source_array)

sorted_array = my_tree.inorder_traverse
p sorted_array

my_baltree = BBST.new
my_baltree.root = my_baltree.build_tree(sorted_array)
my_baltree.pretty_print
