class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    root = Node.new(array[mid])
    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[mid + 1..])
    root
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert(value, node.left)
    elsif value > node.data
      node.right = insert(value, node.right)
    end
    node
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      min_larger_node = find_min(node.right)
      node.data = min_larger_node.data
      node.right = delete(min_larger_node.data, node.right)
    end
    node
  end

  def find_min(node)
    return nil if node.nil?
    return node if node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  def level_order
    return [] if @root.nil?

    queue = [@root]
    result = []
    until queue.empty?
      node = queue.shift
      result << (block_given? ? yield(node) : node.data)
      queue << node.left if node.left
      queue << node.right if node.right
    end
    result
  end

  def inorder(node = @root, result = [], &block)
    return result if node.nil?

    inorder(node.left, result, &block)
    result << (block_given? ? yield(node) : node.data)
    inorder(node.right, result, &block)
    result
  end

  def preorder(node = @root, result = [], &block)
    return result if node.nil?

    result << (block_given? ? yield(node) : node.data)
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)
    result
  end

  def postorder(node = @root, result = [], &block)
    return result if node.nil?

    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    result << (block_given? ? yield(node) : node.data)
    result
  end

  def height(node = @root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    [left_height, right_height].max + 1
  end

  def depth(node, current_node = @root, current_depth = 0)
    return nil if current_node.nil?
    return current_depth if current_node == node

    left = depth(node, current_node.left, current_depth + 1)
    right = depth(node, current_node.right, current_depth + 1)
    left || right
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    sorted_nodes = inorder
    @root = build_tree(sorted_nodes)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
