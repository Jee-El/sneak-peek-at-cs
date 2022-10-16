# frozen_string_literal: true

require_relative 'knight'
require_relative 'graph'

knight = Knight.new
graph = Graph.new(knight.directions)

shortest_path = graph.shortest_path([0, 0], [7, 7])

num_of_moves = shortest_path.length - 1

puts "You made it in #{num_of_moves} moves!"

shortest_path.each do |move|
  puts "Col: #{move.first}, Row: #{move.last}"
end
