# frozen_string_literal: true

# Node Class
class Node
  attr_reader :next_node, :value

  def initialize(given_name = nil)
    @value = given_name
    @next_node = nil
  end

  def pointer(next_node)
    @next_node = next_node
  end
end
