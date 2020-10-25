# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants::HasAtLeastOneExit
  class << self
    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def validate!(nodes, edges)
      bound_nodes = find_bounds(nodes, edges)

      raise(
        MetaStruct::Graph::NoExitNodeInvariantError,
        'Your graph has no exit nodes (you should provide at least one exit node).'
      ) if bound_nodes.size == 0
    end

    private

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [Array<MetaStruct::Graph::Node>]
    #
    # @api private
    # @since 0.1.0
    def find_bounds(nodes, edges)
      right_nodes = edges.map(&:right_node)
      left_nodes = edges.map(&:left_node)

      right_nodes - left_nodes
    end
  end
end
