# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Point::Factory
  class << self
    # @param node [MetaStruct::Graph::Node]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def create(node)
      MetaStruct::Graph::Point.new(node)
    end

    # @param point [MetaStruct::Graph::Point]
    # @param adjacencies [Array<MetaStruct::Graph::Point::Adjacency>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def append_adjacencies(point, adjacencies)
      point.__adjacencies__.concat(adjacencies)
    end
  end
end
