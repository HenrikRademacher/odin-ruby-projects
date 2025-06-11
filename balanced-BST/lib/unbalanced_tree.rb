# frozen_string_literal: true

# Binary search tree class
class BST
  attr_reader :root

  def initialize
    @root = nil
  end

  def populate(input_array)
    @root = Node.new(input_array.shift)
    input_array.each { |array_value| place_value(array_value) }
  end

  def place_value(array_value)
    current_node = @root
    parent_node = nil
    while parent_node.nil?
      if current_node.value == array_value
        current_node.increase_amount
        return
      elsif current_node.value < array_value && !current_node.right_child.nil?
        current_node = current_node.right_child
      elsif current_node.value > array_value && !current_node.left_child.nil?
        current_node = current_node.left_child
      else
        parent_node = current_node
      end
    end

    current_node = Node.new(array_value)
    parent_node.left_child = current_node if current_node.value < parent_node.value
    parent_node.right_child = current_node if current_node.value > parent_node.value
  end

  def inorder_traverse
    # left - center - right
    my_array = []
    my_nodes = []
    my_nodes << @root
    until my_nodes.empty?
      current_node = my_nodes.pop
      if current_node.instance_of?(Node)
        my_nodes << current_node.right_child unless current_node.right_child.nil?
        current_node.amount.times { my_nodes << current_node.value }
        my_nodes << current_node.left_child unless current_node.left_child.nil?
      else
        my_array << current_node
      end
    end
    my_array
  end
end
