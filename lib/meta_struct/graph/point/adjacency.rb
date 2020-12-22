# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Point::Adjacency
  # @return [MetaStruct::Graph::Point]
  #
  # @api private
  # @since 0.1.0
  attr_reader :left_point

  # @return [MetaStruct::Graph::Point]
  #
  # @api private
  # @since 0.1.0
  attr_reader :right_point

  # @return [MetaStruct::Graph::Edge]
  #
  # @api private
  # @since 0.1.0
  attr_reader :edge

  # @param left_point [MetaStruct::Graph::Point]
  # @param right_point [MetaStruct::Graph::Point]
  # @param edge [MetaStruct::Graph::Edge]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(left_point, right_point, edge)
    @left_point = left_point
    @right_point = right_point
    @edge = edge
  end

  # @return [Integer]
  #
  # @api public
  # @since 0.1.0
  def weight
    edge.weight
  end

  # @return [MetaStruct::Graph::Node]
  #
  # @api public
  # @since 0.1.0
  def left_node
    edge.left_node
  end

  # @return [MetaStruct::Graph::Node]
  #
  # @api public
  # @since 0.1.0
  def right_node
    edge.right_node
  end

  # @return [Array<String,Symbol>]
  #
  # @api public
  # @since 0.1.0
  def edge_labels
    edge.labels
  end

  # @return [Hash<String|Symbol,Any>]
  #
  # @api public
  # @since 0.1.0
  def edge_properties
    edge.properties
  end

  # @return [Boolean]
  #
  # @api public
  # @since 0.1.0
  def end?
    right_point == nil
  end
end
