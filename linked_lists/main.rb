# frozen_string_literal: true

# I used a lot of recursion in the LinkedList class
# because who doesn't love recursion?
# and since all of them are tail-recursive
# I thought why not enable Tail Call Optimization
# Note: this isn't necessary, it'll work either way.
RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

require 'tty-table'
require_relative 'node'
require_relative 'linked_list'

def draw_linked_list_data(linked_list)
  puts TTY::Table.new(
    %w[linked_list size head tail],
    [[
      linked_list,
      linked_list.size,
      linked_list.head,
      linked_list.tail
    ]]
  ).render(:ascii, padding: [0, 1])
end

linked_list = LinkedList.new

draw_linked_list_data(linked_list)
puts

print 'Append \'a\' | return value : '
puts linked_list.append('a')
draw_linked_list_data(linked_list)
puts

print 'Append \'b\' | return value : '
puts linked_list.append('b')
draw_linked_list_data(linked_list)
puts

print 'Prepend \'f\' | return value : '
puts linked_list.prepend('f')
draw_linked_list_data(linked_list)
puts

print 'Prepend \'z\' | return value : '
puts linked_list.prepend('z')
draw_linked_list_data(linked_list)
puts

print 'Append \'i\' | return value : '
puts linked_list.append('i')
draw_linked_list_data(linked_list)
puts

print '\'c\' exists? | return value : '
puts linked_list.contains?('c')
draw_linked_list_data(linked_list)
puts

print 'Insert \'c\' before \'i\' | return value : '
puts linked_list.insert_at('c', 4)
draw_linked_list_data(linked_list)
puts

print '\'c\' exists? | return value : '
puts linked_list.contains?('c')
draw_linked_list_data(linked_list)
puts

print 'Find \'c\' | return value : '
puts linked_list.find('c')
draw_linked_list_data(linked_list)
puts

print 'Node at index 2 | return value : '
puts linked_list.at(2)
draw_linked_list_data(linked_list)
puts

print 'Remove node at index 2 | return value : '
puts linked_list.remove_at(2)
draw_linked_list_data(linked_list)
puts

print 'Node at index 2 isn\'t the old one anymore? (removed?) | return value : '
puts linked_list.at(2)
draw_linked_list_data(linked_list)
puts

print 'Popped last node? | return value : '
puts linked_list.pop
draw_linked_list_data(linked_list)
puts

print 'Out of bound index? | return value : '
p linked_list.at(232)
draw_linked_list_data(linked_list)
puts
