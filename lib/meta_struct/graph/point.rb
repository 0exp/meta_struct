# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Point
  require_relative 'point/adjacency'
  require_relative 'point/factory'
  require_relative 'point/tree_factory'
  require_relative 'point/iterator'

  # @return [MetaStruct::Graph::Node]
  #
  # @api public
  # @since 0.1.0
  attr_reader :node

  # @return [Array<MetaStruct::Graph::Point>]
  #
  # @api private
  # @since 0.1.0
  attr_accessor :adjacencies

  # @param node [MetaStruct::Graph::Node]
  # @param adjacencies [Array<MetaStruct::Graph::Point>]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(node, adjacencies = [])
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

  # @return [Array<Strinng>]
  #
  # @api public
  # @since 0.1.0
  def labels
    node.labels
  end

  # @return [Hash<String,Any>]
  #
  # @api public
  # @since 0.1.0
  def properties
    node.properties
  end

  # @return [Boolean]
  #
  # @api public
  # @since 0.1.0
  def adjacencies?
    adjacencies.any?
  end
end
