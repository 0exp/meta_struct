# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms::PointsIterator
  class << self
    # @param graph [MetaStruct::Graph]
    # @option from_uuid [String, nil]
    # @param iterator [Block]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def call(graph, from_uuid: nil, &iterator)
      start_point = find_start_point(graph, from_uuid)
      adjacency = MetaStruct::Graph::Algorithms::FindAdjacency
        .call(graph, start_point)

      deep_iterate(start_point, adjacency, &iterator)
    end

    private

    # @param graph [MetaStruct::Graph]
    # @param from_uuid [String, nil]
    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def find_start_point(graph, from_uuid)
      return graph.root unless from_uuid && !from_uuid.empty?

      graph.find_point(from_uuid)
    end

    # @param point [MetaStruct::Graph::Point]
    # @param adjacency [MetaStruct::Graph::Point::Adjacency]
    # @param iterator [Block]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def deep_iterate(point, adjacency = nil, &iterator)
      result = iterate_point(point, adjacency, &iterator)

      iterate_point_adjacencies(point, &iterator) if result
    end

    # @param point [MetaStruct::Graph::Point]
    # @param adjacency [MetaStruct::Graph::Point::Adjacency]
    # @param iterator [Block]
    # @return [Boolean]
    #
    # @api private
    # @since 0.1.0
    def iterate_point(point, adjacency, &iterator)
      yield(point, adjacency)
    end

    # @param point [MetaStruct::Graph::Point]
    # @param iterator [Block]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
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

    # @param adjacencies [Array<MetaStruct::Graph::Point::Adjacency>]
    # @return [Array<MetaStruct::Graph::Point::Adjacency>]
    #
    # @api private
    # @since 0.1.0
    def sorted_adjacencies(adjacencies = [])
      adjacencies.sort_by(&:weight)
    end
  end
end
