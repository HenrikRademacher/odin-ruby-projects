# frozen_string_literal: true

# Node for binary search tree
class BalNode
  include Comparable

  attr_accessor :value, :left_child, :right_child

  def initialize(val_num_array)
    @value = val_num_array[0]
    @amount = val_num_array[1]
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
