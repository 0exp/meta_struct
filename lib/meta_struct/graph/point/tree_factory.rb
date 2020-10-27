# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Point::TreeFactory
  class << self
    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def create(nodes, edges)
      wrrapped_points = wrap_to_points(nodes)

      wrrapped_points.each do |point|
        right_edges = edges.select { |edge| edge.left_node.uuid == point.node.uuid }

        next unless right_edges.any?
        
        point.adjacencies = adjacencies_for(point, right_edges)
      end

      wrrapped_points.first
    end

    private
    
    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @return [Array<MetaStruct::Graph::Point>]
    #
    # @api private
    # @since 0.1.0
    def wrap_to_points(nodes)
      nodes.map(&method(:build_point_for))
    end

    # @param nodes [MetaStruct::Graph::Node]
    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def build_point_for(node)
      MetaStruct::Graph::Point::Factory.build(node)
    end

    # @param nodes [MetaStruct::Graph::Point]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [Array<MetaStruct::Graph::Point::Adjacency>]
    #
    # @api private
    # @since 0.1.0
    def adjacencies_for(point, right_edges)
      right_edges.map do |edge|
        MetaStruct::Graph::Point::Adjacency.new(
          point,
          build_point_for(edge.right_node)
        )
      end
    end
  end
end
