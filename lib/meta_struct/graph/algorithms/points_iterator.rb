# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms::PointsIterator
  class << self
    def call(graph, from_uuid: nil, &iterator)
      start_point = find_start_point(graph, from_uuid)
      adjacency = MetaStruct::Graph::Algorithms::FindAdjacency
        .call(graph, start_point)

      deep_iterate(start_point, adjacency, &iterator)
    end

    private

    def find_start_point(graph, from_uuid)
      return graph.root unless from_uuid && !from_uuid.empty?

      graph.find_point(from_uuid)
    end

    def deep_iterate(point, adjacency = nil, &iterator)
      iterate_point(point, adjacency, &iterator)

      iterate_point_adjacencies(point, &iterator)
    end

    def iterate_point(point, adjacency, &iterator)
      yield(point, adjacency)
    end

    def iterate_point_adjacencies(point, &iterator)
      adjacencies = sorted_adjacencies(point.adjacencies)

      adjacencies.each do |adjacency|
        next_point = adjacency.right_point
        result = iterate_point(next_point, adjacency, &iterator)

        break if result && !next_point.adjacencies?
        next unless result

        iterate_point_adjacencies(next_point, &iterator)
      end
    end

    def sorted_adjacencies(adjacencies = [])
      adjacencies.sort do |left, right|
        right.weight <=> left.weight
      end
    end
  end
end
