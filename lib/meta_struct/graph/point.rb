# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Point
  # @return [MetaStruct::Graph::Node]
  #
  # @api private
  # @since 0.1.0
  attr_reader :node

  # @return [Array<MetaStruct::Graph::Edge>]
  #
  # @api private
  # @since 0.1.0
  attr_reader :edges

  attr_reader :children

  # @param node [MetaStruct::Graph::Node]
  # @param edges [Array<MetaStruct::Graph::Edge>]
  # @return [void]
  #
  # @api public
  # @since 0.1.0
  def initialize(node, edges)
    @node = node
    @edges = edges
    @children = []
  end

  def add_children(points)
    @children += points
  end
end
