# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Point::Iterator::Entity
  # @return [MetaStruct::Graph::Point]
  #
  # @api private
  # @since 0.1.0
  attr_reader :point

  # @return [MetaStruct::Graph::Point::Adjacency]
  #
  # @api private
  # @since 0.1.0
  attr_reader :adjacency

  # @param point [MetaStruct::Graph::Point]
  # @param adjacency [MetaStruct::Graph::Point::Adjacency, nil]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(point, adjacency = nil)
    @point = point
    @adjacency = adjacency
  end
end
