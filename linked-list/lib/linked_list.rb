# frozen_string_literal: true

# Linked List class
class LinkedList
  def initialize
    @node_count = 0
    @head_node = nil
  end

  def append(node_value)
    my_node = Node.new(node_value)
    if @head_node.nil?
      @head_node = my_node
    else
      tail.pointer(my_node)
    end
    @node_count += 1
  end

  def prepend(node_value)
    my_node = Node.new(node_value)
    my_node.pointer(@head_node)
    @head_node = my_node
    @node_count += 1
  end

  def head
    @head_node
  end

  def tail
    current_node = head
    following_node = current_node.next_node
    until following_node.nil?
      current_node = following_node
      following_node = current_node.next_node
    end
    current_node
  end

  def pop
    return if size.zero?

    if size == 1
      @head_node = nil
    else
      at(size - 2).pointer(nil)
    end
    @node_count -= 1
  end

  def size
    @node_count
  end

  def at(index)
    current_node = head
    index.times do
      current_node = current_node.next_node
    end
    current_node
  end

  def contains?(given_value)
    answer = false
    index = 0
    until answer == true || index == size
      answer = true if given_value == at(index).value
      index += 1
    end
    answer
  end

  def find(given_value)
    answer = false
    index = -1
    until answer == true || index + 1 == size
      index += 1
      answer = true if given_value == at(index).value
    end
    return nil if answer == false

    index
  end

  def to_s
    string = "( #{head.value} )"
    (size - 1).times { |number| string += " -> ( #{at(number).next_node.value} )" }
    string += ' -> nil'
    string
  end

  def insert_at(value, index)
    my_node = Node.new(value)
    @node_count += 1
    my_node.pointer(at(index))
    if index.zero?
      @head_node = my_node
    else
      at(index - 1).pointer(my_node)
    end
  end

  def remove_at(index)
    at(index - 1).pointer(at(index + 1))
    @node_count -= 1
  end
end
