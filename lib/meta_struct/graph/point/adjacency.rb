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

  # @param left_point [MetaStruct::Graph::Point]
  # @param right_point [MetaStruct::Graph::Point]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(left_point, right_point)
    @left_point = left_point
    @right_point = right_point
  end
end
