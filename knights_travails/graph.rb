# frozen_string_literal: true

class Graph
  attr_reader :vertices, :adjacency_list

  def initialize(moves)
    @vertices = [*0..7].product([*0..7])
    @adjacency_list = build_adjacency_list(moves)
  end

  def build_adjacency_list(moves)
    adjacency_list = {}
    @vertices.each do |vertex|
      adjacent_vertices = moves.filter_map do |column, row|
        column += vertex.first
        row += vertex.last
        [column, row] if valid_coordinates?(column, row)
      end
      adjacency_list[vertex] = adjacent_vertices
    end
    adjacency_list
  end

  def shortest_path(start, goal)
    coordinates = start + goal
    return invalid_coordinates unless valid_coordinates?(*coordinates)
    return [start] if start == goal

    bfs(start, goal)
  end

  def to_s
    @adjacency_list.to_s
  end

  private

  def bfs(start, goal, paths = [[start]], vertices = [start])
    path = paths.shift
    vertex = vertices.shift
    return path if vertex == goal

    @adjacency_list[vertex].each do |adjacent_vertex|
      next if vertices.include?(adjacent_vertex)

      new_path = path + [adjacent_vertex]
      paths.push(new_path)
      vertices.push(adjacent_vertex)
    end
    bfs(start, goal, paths, vertices)
  end

  def valid_coordinates?(*coordinates)
    coordinates.all? { _1.between?(0, 7) }
  end

  def invalid_coordinates
    puts 'Invalid coordinates'
  end
end
