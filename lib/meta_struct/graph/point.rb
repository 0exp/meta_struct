# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Point
  require_relative 'point/edge'
  require_relative 'point/factory'
  require_relative 'point/tree_factory'

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

  # @param node [MetaStruct::Graph::Node]
  # @param edges [Array<MetaStruct::Graph::Edge>]
  # @return [void]
  #
  # @api public
  # @since 0.1.0
  def initialize(node, edges)
    @node = node
    @edges = edges
  end
end
