# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Point::Adjacency
  # @return [MetaStruct::Graph::Edge]
  #
  # @api private
  # @since 0.1.0
  attr_reader :edge

  # @return [MetaStruct::Graph::Point]
  #
  # @api public
  # @since 0.1.0
  attr_reader :left_point

  # @return [MetaStruct::Graph::Point]
  #
  # @api public
  # @since 0.1.0
  attr_reader :right_point

  # @param edge [MetaStruct::Graph::Edge]
  # @param left_point [MetaStruct::Graph::Point]
  # @param right_point [MetaStruct::Graph::Point]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(edge, left_point, right_point)
    @edge = edge
    @left_point = left_point
    @right_point = right_point
  end

  # @return [Integer]
  #
  # @api public
  # @since 0.1.0
  def weight
    edge.weight
  end
end
