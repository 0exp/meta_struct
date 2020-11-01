# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms::FindNode
  class << self
    # @param graph [MetaStruct::Graph]
    # @param node_uuid [String]
    # @return [MetaStruct::Graph::Point, nil]
    #
    # @api private
    # @since 0.1.0
    def call(graph, node_uuid)
      MetaStruct::Graph::Algorithms::DeepTraversal.traverse(graph) do |point|
        return point if point.uuid == node_uuid
      end
      nil
    end

    # @param graph [MetaStruct::Graph]
    # @param node_uuid [String]
    # @return [MetaStruct::Graph::Point, nil]
    #
    # @api private
    # @since 0.1.0
    def call!(graph, node_uuid)
      call(graph, node_uuid) || raise(
        MetaStruct::Graph::PointNotFoundError,
        "Node with UUID '#{node_uuid}' not found."
      )
    end
  end
end
