# frozen_string_literal: true

# Node of Hashmap
class Node
  attr_reader :key, :value, :next_node

  def initialize(key, value)
    @key = key
    @value = value
    @next_node = nil
  end

  def write_value(new_value)
    @value = new_value
  end

  def write_next(new_node)
    @next_node = new_node
  end
end
