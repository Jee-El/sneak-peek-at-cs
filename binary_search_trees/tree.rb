# frozen_string_literal: true

class Tree
  def initialize(arr)
    arr = arr.sort.uniq
    @root = build_tree(arr)
  end

  def build_tree(arr)
    return if arr.empty?

    mid = arr.length / 2
    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid + 1..])

    root
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return puts 'nil' unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end

  def insert(value, node = @root)
    return if node&.data == value

    return Node.new(value) unless node

    if value < node.data
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end
    node
  end

  def delete(value)
    node = find(value)
    return delete_leaf(node) if leaf?(node)
    return delete_node_of_1_child(node) if one_child?(node)

    delete_node_of_2_children(node) if two_children?(node)
  end

  def leaf?(node)
    [node.left, node.right].all?(&:nil?)
  end

  def one_child?(node)
    [node.left, node.right].one?(&:nil?)
  end

  def two_children?(node)
    [node.left, node.right].none?(&:nil?)
  end

  def inorder_successor(node)
    node = node.left until node.left.nil?
    node
  end

  def find_root(value, node = @root)
    return unless node
    return node if [node.data, node.left&.data, node.right&.data].include?(value)

    node.data > value ? find_root(value, node.left) : find_root(value, node.right)
  end

  def find(value)
    root = find_root(value)
    return unless root

    return root if root.data == value

    root.left&.data == value ? root.left : root.right
  end

  def iterative_level_order
    nodes = [@root]
    loop do
      yield nodes[0]
      prev_first_node = nodes.shift
      nodes.push(prev_first_node.left) if prev_first_node.left
      nodes.push(prev_first_node.right) if prev_first_node.right
      break if nodes.empty?
    end
  end

  def recursive_level_order(nodes = [@root], &block)
    return if nodes.empty?

    block[nodes[0]]
    prev_first_node = nodes.shift
    nodes.push(prev_first_node.left) if prev_first_node.left
    nodes.push(prev_first_node.right) if prev_first_node.right
    recursive_level_order(nodes, &block)
  end

  def preorder(node = @root, &block)
    return no_block_given unless block

    return unless node

    block[node]
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  def inorder(node = @root, &block)
    return no_block_given unless block

    return unless node

    inorder(node.left, &block)
    block[node]
    inorder(node.right, &block)
  end

  def postorder(node = @root, &block)
    return no_block_given unless block

    return unless node

    postorder(node.left, &block)
    postorder(node.right, &block)
    block[node]
  end

  def height(node, value = -1)
    return value unless node

    left_height = height(node.left, value + 1)
    right_height = height(node.right, value + 1)

    [left_height, right_height].max
  end

  def depth(node, current_node = @root, value = -1)
    return value + 1 if !current_node || node.data == current_node.data

    if current_node.data > node.data
      depth(node, current_node.left, value + 1)
    else
      depth(node, current_node.right, value + 1)
    end
  end

  def balanced?
    iterative_level_order do |node|
      left_height = height(node.left)
      right_height = height(node.right)
      difference = (left_height - right_height).abs
      return false if difference > 1
    end
    true
  end

  def rebalance
    new_arr = []
    inorder { |node| new_arr.push(node.data) }
    @root = build_tree(new_arr)
  end

  private

  def delete_leaf(leaf)
    root = find_root(leaf.data)
    root.left = root.right = nil
    leaf
  end

  def delete_node_of_1_child(child)
    deleted_child = child

    child.data = child.left&.data || child.right&.data

    child.left = child.left&.left

    child.right = child.right&.right

    deleted_child
  end

  def delete_node_of_2_children(node)
    successor_data = inorder_successor(node.right).data
    delete(successor_data)
    node.data = successor_data
  end

  def no_block_given
    data = []
    preorder { |node| data << node.data }
    data
  end
end
