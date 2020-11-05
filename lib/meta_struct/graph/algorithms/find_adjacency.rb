# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms::FindAdjacency
  class << self
    # @param graph [MetaStruct::Graph]
    # @param point [MetaStruct::Graph::Point]
    # @return [MetaStruct::Graph::Point::Adjacency, nil]
    #
    # @api private
    # @since 0.1.0
    def call(graph, point)
      root = graph.root

      return if root.uuid == point.uuid

      stack = [root]
      needed_adjacency = nil

      while stack.any?
        current = stack.pop

        current.adjacencies.each do |adjacency|
          right_point = adjacency.right_point

          if right_point.uuid == point.uuid
            needed_adjacency = adjacency
            stack = []
          else
            stack.push(right_point)
          end
        end
      end

      needed_adjacency
    end
  end
end
