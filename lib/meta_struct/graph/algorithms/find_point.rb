# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms::FindPoint
  class << self
    # @param graph [MetaStruct::Graph]
    # @param node_uuid [String]
    # @return [MetaStruct::Graph::Point, nil]
    #
    # @api private
    # @since 0.1.0
    def call(graph, node_uuid = nil)
      point = nil
      root = graph.root

      return unless node_uuid && !node_uuid.empty?
      return root if root.node.uuid == node_uuid

      stack = [root]

      while stack.any? do
        current = stack.pop

        current.adjacencies.each do |adjacency|
          right_point = adjacency.right_point

          if right_point.node.uuid == node_uuid
            point = right_point
            stack = []
          else
            stack.push(right_point)
          end
        end
      end

      point
    end
  end
end
