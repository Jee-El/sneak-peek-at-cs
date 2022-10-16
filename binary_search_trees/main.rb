# frozen_string_literal: true

require_relative 'tree'
require_relative 'node'

random_numbers = Array.new(15) { rand(1..100) }

tree = Tree.new random_numbers

tree.pretty_print

puts "Balanced? #{tree.balanced?}"

print 'Inorder : '
tree.inorder { |node| print "#{node.data} " }
puts '.'

15.times { tree.insert(rand(101..1000)) }

tree.pretty_print

puts "Balanced? #{tree.balanced?}"

tree.rebalance

tree.pretty_print

puts "Balanced? #{tree.balanced?}"

print 'Preorder : '
tree.preorder { |node| print "#{node.data} " }
puts '.'

print 'Inorder : '
tree.inorder { |node| print "#{node.data} " }
puts '.'

print 'Postorder : '
tree.postorder { |node| print "#{node.data} " }
puts '.'

print 'Level order : '
tree.iterative_level_order { |node| print "#{node.data} " }
puts '.'
