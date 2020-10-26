# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Point
  require_relative 'point/adjacency'
  require_relative 'point/factory'
  require_relative 'point/tree_factory'

  # @return [MetaStruct::Graph::Node]
  #
  # @api public
  # @since 0.1.0
  attr_reader :node

  # @return [Array<MetaStruct::Graph::Point>]
  #
  # @api private
  # @since 0.1.0
  attr_reader :adjacencies

  # @param node [MetaStruct::Graph::Node]
  # @param adjacencies [Array<MetaStruct::Graph::Point>]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(node, adjacencies)
    @node = node
    @adjacencies = adjacencies
  end

  # @return [String]
  #
  # @api public
  # @since 0.1.0
  def uuid
    node.uuid
  end
end
