# frozen_string_literal: true

# Node for binary search tree
class Node
  include Comparable

  attr_accessor :value, :left_child, :right_child, :amount

  def initialize(value)
    @value = value
    @amount = 1
    @left_child = nil
    @right_child = nil
  end

  def <=>(other)
    @value <=> other.value
  end

  def increase_amount
    @amount += 1
  end
end
