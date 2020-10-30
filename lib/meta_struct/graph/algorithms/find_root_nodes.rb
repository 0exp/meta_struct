# frozen_string_literal: true

# @api public
# @since 0.1.0
module MetaStruct::Graph::Algorithms::FindRootNodes
  class << self
    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [Array<MetaStruct::Graph::Node>]
    #
    # @api public
    # @since 0.1.0
    def call(nodes, edges)
      nodes - find_bounds(nodes, edges)
    end

    private

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [Array<MetaStruct::Graph::Node>]
    #
    # @api private
    # @since 0.1.0
    def find_bounds(nodes, edges)
      nodes.select { |node| edges.any? { |edge| edge.right_node == node } }
    end
  end
end
