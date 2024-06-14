require('./binary_search_trees')

tree = Tree.new(Array.new(15) { rand(1..100) })

puts 'Initial tree:'
tree.pretty_print
puts "\nIs the tree balanced? #{tree.balanced?}"
puts "Level-order: #{tree.level_order}"
puts "Pre-order: #{tree.preorder}"
puts "Post-order: #{tree.postorder}"
puts "In-order: #{tree.inorder}"

puts "\nUnbalancing the tree by adding values > 100..."
[101, 102, 103, 104, 105].each { |value| tree.insert(value) }
tree.pretty_print
puts "\nIs the tree balanced? #{tree.balanced?}"

puts "\nRebalancing the tree..."
tree.rebalance
tree.pretty_print
puts "\nIs the tree balanced? #{tree.balanced?}"
puts "Level-order: #{tree.level_order}"
puts "Pre-order: #{tree.preorder}"
puts "Post-order: #{tree.postorder}"
puts "In-order: #{tree.inorder}"
