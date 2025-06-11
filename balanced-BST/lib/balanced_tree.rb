# frozen_string_literal: true

# Balanced binary search tree
class BBST
  attr_accessor :root

  def initialize
    @root = nil
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def build_tree(input_array)
    return nil if input_array.nil? || input_array.empty?

    pivot = input_array.length / 2
    left_part = input_array.shift(pivot) if pivot.positive?
    mid = input_array.shift
    right_part = input_array
    current_node = BalNode.new([mid, 1])
    current_node.left_child = build_tree(left_part) unless left_part.nil?
    current_node.right_child = build_tree(right_part) unless right_part.nil?
    current_node
  end
end
