# frozen_string_literal: true

# Class Hashset
class Hashset
  attr_reader :buckets

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(16)
    @stored_keys = 0
  end

  def find_node(key)
    node_array = gather_hashnodes(key)
    answer = nil
    node_array.each do |node|
      answer = node if node.key == key
    end
    answer
  end

  def gather_hashnodes(key)
    node_array = []
    my_hash = hash(key)
    my_node = @buckets[my_hash]
    return node_array if my_node.nil?

    node_array << my_node
    until my_node.next_node.nil?
      my_node = my_node.next_node
      node_array << my_node
    end
    node_array
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

  def gather_nodes
    node_array = []
    @buckets.each do |bucket|
      next if bucket.nil?

      node_array << bucket
      until bucket.next_node.nil?
        bucket = bucket.next_node
        node_array << bucket
      end
    end
    node_array
  end

  def check_resize
    if @stored_keys > @capacity * @load_factor
      @capacity *= 2
      puts 'begins doubled reassignment'
      reassign_buckets
      return nil
    end
    if @capacity > 16 && @stored_keys < (@capacity * @load_factor) / 2 # rubocop:disable Style/GuardClause
      @capacity /= 2
      puts 'begins halved reassignment'
      reassign_buckets
      return nil # rubocop:disable Style/RedundantReturn
    end
  end

  def reassign_buckets
    node_array = gather_nodes
    @buckets = Array.new(16)
    node_array.each do |node|
      @stored_keys -= 1
      set(node.key)
    end
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code %= @capacity
  end

  def set(key)
    my_node = find_node(key)
    return nil unless my_node.nil?

    my_node = Node.new(key)
    @stored_keys += 1
    implement_node(my_node)

    puts "#{key} stored in bucket #{hash(key)}, #{@stored_keys}/#{@capacity}"
    check_resize
  end

  def get(key)
    my_node = find_node(key)
    return my_node unless my_node.nil?

    nil
  end

  def has?(key)
    return true unless find_node(key).nil?

    false
  end

  def remove(key)
    node_array = gather_hashnodes(key)
    my_node = find_node(key)
    return nil if my_node.nil?

    index_in_hash = node_array.index(my_node)
    if index_in_hash.zero?
      @buckets[hash(key)] = my_node.next_node
    else
      previous_node = node_array[index_in_hash - 1]
      previous_node.write_next(my_node.next_node)
    end
    @stored_keys -= 1
    puts "#{key} removed from bucket #{hash(key)}, #{@stored_keys}/#{@capacity}"
    check_resize
    my_node.value
  end

  def length
    @stored_keys
  end

  def clear
    @buckets = Array.new(16)
    @stored_keys = 0
  end

  def entries
    node_array = gather_nodes
    key_array = []
    node_array.each do |node|
      key_array << node.key
    end
    key_array
  end
end
