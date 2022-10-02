# frozen_string_literal: true

class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    return (@head = @tail = Node.new(value)) && self unless @head

    last_node = at(-1)

    (@tail = last_node.next_node = Node.new(value)) && self
  end

  def prepend(value)
    return append(value) unless @head

    (@head = Node.new(value, @head)) && self
  end

  def size(current_node = head, value = 0)
    return value unless current_node

    size(current_node.next_node, value + 1)
  end

  def at(index, current_node = head, current_index = index >= 0 ? 0 : -size)
    return nil unless current_node

    return current_node if current_index == index

    at(index, current_node.next_node, current_index + 1)
  end

  def pop
    @tail = new_last_node = at(-2)

    prev_last_node = new_last_node.next_node
    new_last_node.next_node = nil

    prev_last_node
  end

  def contains?(value, current_node = head)
    return true if current_node.value == value
    return false unless current_node.next_node

    contains?(value, current_node.next_node)
  end

  def find(value, index = 0)
    return nil unless at(index)

    return index if at(index).value == value

    find(value, index + 1)
  end

  def to_s(current_node = head, str = '')
    return "#{str}nil" unless current_node

    to_s(current_node.next_node, str + "( #{current_node.value} ) -> ")
  end

  def insert_at(value, index)
    before_index_node = at(index - 1)
    before_index_node.next_node = Node.new(value, before_index_node.next_node)
    self
  end

  def remove_at(index)
    before_index_node = at(index - 1)
    removed_node = before_index_node.next_node
    before_index_node.next_node = removed_node.next_node
    removed_node
  end
end
