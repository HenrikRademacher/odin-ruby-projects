# frozen_string_literal: true

# Node for unbalanced search tree
class Node
  attr_accessor :value, :left_child, :right_child

  def initialize(value)
    @value = value
    @amount = 1
    @left_child = nil
    @right_child = nil
  end

  def increase_amount
    @amount += 1
  end
end
