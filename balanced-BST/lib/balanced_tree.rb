# frozen_string_literal: true

# Balanced binary search tree
class BBST
  attr_accessor :root

  def initialize
    @root = nil
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '|   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '|   '}", true) if node.left_child
  end

  def populate(input_array)
    new_array = refine_duplicates(input_array)
    @root = build_tree(new_array)
  end

  def refine_duplicates(input_array)
    new_array = []
    until input_array.empty?
      element = input_array[0]
      new_array << [element, input_array.count(element)]
      input_array.delete(element)
    end
    new_array
  end

  def inorder_successor(given_node)
    return given_node if given_node.left_child.nil?

    inorder_successor(given_node.left_child)
  end

  def inorder_successor_parent(given_node)
    return given_node if given_node.left_child.nil? || given_node.left_child.left_child.nil?

    inorder_successor_parent(given_node.left_child)
  end

  def build_tree(input_array)
    return nil if input_array.nil? || input_array.empty?

    pivot = input_array.length / 2
    left_part = input_array.shift(pivot) if pivot.positive?
    mid = input_array.shift
    right_part = input_array
    current_node = BalNode.new(mid)
    current_node.left_child = build_tree(left_part) unless left_part.nil?
    current_node.right_child = build_tree(right_part) unless right_part.nil?
    current_node
  end

  def insert(value)
    stop = false
    current_node = @root
    until stop
      case value <=> current_node.value
      when 0
        current_node.increase_amount
        stop = true
      when -1
        if current_node.left_child.nil?
          current_node.left_child = BalNode.new([value, 1])
          stop = true
        else
          current_node = current_node.left_child
        end
      when 1
        if current_node.right_child.nil?
          current_node.right_child = BalNode.new([value, 1])
          stop = true
        else
          current_node = current_node.right_child
        end
      end
    end
  end

  def delete(value)
    stop = false
    current_node = @root
    prev_node = nil
    until stop
      return if current_node.nil?

      case value <=> current_node.value
      when 0
        if current_node.amount > 1
          current_node.decrease_amount
        elsif current_node.left_child.nil? && current_node.right_child.nil?
          prev_node.left_child = nil if prev_node.left_child == current_node
          prev_node.right_child = nil if prev_node.right_child == current_node
        elsif current_node.left_child.nil?
          prev_node.left_child = current_node.right_child if prev_node.left_child == current_node
          prev_node.right_child = current_node.right_child if prev_node.right_child == current_node
        elsif current_node.right_child.nil?
          prev_node.left_child = current_node.left_child if prev_node.left_child == current_node
          prev_node.right_child = current_node.left_child if prev_node.right_child == current_node
        else
          next_node = inorder_successor(current_node.right_child)
          inorder_successor_parent(current_node.right_child).left_child = next_node.right_child
          current_node.value = next_node.value
          current_node.amount = next_node.amount
        end
        stop = true
      when -1
        prev_node = current_node
        current_node = current_node.left_child
      when 1
        prev_node = current_node
        current_node = current_node.right_child
      end
    end
  end

  def find(value, current_node = @root)
    return nil if current_node.nil?

    case value <=> current_node.value
    when 0
      current_node
    when -1
      find(value, current_node.left_child)
    when 1
      find(value, current_node.right_child)
    end
  end

  def itr_level_order
    output_array = []
    working_queue = [@root]
    until working_queue.empty?
      current_node = working_queue.shift
      working_queue.push(current_node.left_child) unless current_node.left_child.nil?
      working_queue.push(current_node.right_child) unless current_node.right_child.nil?
      if block_given?
        current_node.amount.times { yield current_node }
      else
        current_node.amount.times { output_array << current_node.value }
      end
    end
    output_array unless block_given?
  end

  def rec_level_order_helper(current_node = @root, current_level = 0, current_array = [])
    return current_array if current_node.nil?

    current_array = rec_level_order_helper(current_node.left_child, current_level + 1, current_array)
    current_array[current_level] = [] if current_array[current_level].nil?
    current_node.amount.times { current_array[current_level].push(current_node) }
    rec_level_order_helper(current_node.right_child, current_level + 1, current_array)
  end

  def rec_level_order(&block)
    output_array = rec_level_order_helper.flatten
    if block_given?
      output_array.each(&block)
    else
      output_array.collect(&:value)
    end
  end

  def rec_inorder(current_node = @root, current_array = [], &block)
    return current_array if current_node.nil?

    current_array = rec_inorder(current_node.left_child, current_array, &block)
    if block_given?
      current_node.amount.times { yield current_node }
    else
      current_node.amount.times { current_array << current_node.value }
    end
    rec_inorder(current_node.right_child, current_array, &block)
  end

  def rec_preorder(current_node = @root, current_array = [], &block)
    return current_array if current_node.nil?

    if block_given?
      current_node.amount.times { yield current_node }
    else
      current_node.amount.times { current_array << current_node.value }
    end
    current_array = rec_inorder(current_node.left_child, current_array, &block)
    rec_inorder(current_node.right_child, current_array, &block)
  end

  def rec_postorder(current_node = @root, current_array = [], &block)
    return current_array if current_node.nil?

    current_array = rec_inorder(current_node.left_child, current_array, &block)
    current_array = rec_inorder(current_node.right_child, current_array, &block)
    if block_given?
      current_node.amount.times { yield current_node }
    else
      current_node.amount.times { current_array << current_node.value }
    end
    current_array
  end
end
