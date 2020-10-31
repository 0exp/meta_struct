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
  attr_reader :__adjacencies__

  # @param node [MetaStruct::Graph::Node]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(node)
    @node = node
    @__adjacencies__ = []
  end

  # @return [String]
  #
  # @api public
  # @since 0.1.0
  def uuid
    node.uuid
  end

  # A list of adjacencies sorted in ascending order.
  #
  # @return [Array<MetaStruct::Graph::Point>]
  #
  # @api public
  # @since 0.1.0
  def adjacencies
    __adjacencies__.sort_by(&:weight)
  end
end
