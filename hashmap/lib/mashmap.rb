# frozen_string_literal: true

# Class Hashmap
class Hashmap
  attr_reader :buckets

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(16)
    @stored_keys = 0
  end

  def find_node(key)
    my_hash = hash(key)
    return nil if my_hash >= @buckets.length
    return nil if @buckets[my_hash].nil?

    my_node = @buckets[my_hash]
    my_node = my_node.next_node until my_node.nil? || my_node.key == key
    return my_node unless my_node.nil?

    nil
  end

  def implement_node(new_node)
    my_hash = hash(new_node.key)
    if @buckets[my_hash].nil?
      @buckets[my_hash] = new_node
    else
      last_node = @buckets[my_hash]
      last_node = last_node.next_node until last_node.next_node.nil?
      last_node.write_next(new_node)
    end
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code %= @capacity
  end

  def set(key, value)
    my_node = find_node(key)
    if my_node.nil?
      my_node = Node.new(key, value)
      @stored_keys += 1
      implement_node(my_node)
    else
      my_node.write_value(value)
    end
    puts "#{key} stored in bucket #{hash(key)}"
  end

  def get(key)
    my_node = find_node(key)
    return my_node.value unless my_node.nil?

    nil
  end

  def has?(key)
    return true unless find_node(key).nil?

    false
  end

  def length
    @stored_keys
  end

  def clear
    @buckets = Array.new(16)
    @stored_keys = 0
  end
end
