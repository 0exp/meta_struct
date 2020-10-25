# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants::HasNoNonconnectedNodes
  class << self
    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def validate!(nodes, edges)
      non_connected_nodes = find_non_connected_nodes(nodes, edges)

      unless non_connected_nodes.empty?
        raise(MetaStruct::Graph::NonConnectedNodeError, <<~ERROR_MESSAGE)
          Some nodes has no edges (all nodes should have edges).
          Non-connected nodes: #{non_connected_nodes.map(&:uuid).join(", ")}.
        ERROR_MESSAGE
      end
    end

    private

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [Boolean]
    #
    # @api private
    # @since 0.1.0
    def find_non_connected_nodes(nodes, edges)
      nodes.reject do |node| edges.any? do |edge|
          edge.left_node == node || edge.right_node == node
        end
      end
    end
  end
end
