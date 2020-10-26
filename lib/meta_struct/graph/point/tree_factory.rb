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
      root_node = find_root(nodes, edges)

      wrrapped_points.each do |uuid, point|
        right_edges = edges.select { |edge| edge.left_node.uuid = uuid }

        next unless right_edges.any?
        
        point.adjacencies = adjacencies_for(point, right_edges)
      end

      wrrapped_points.detect { |point| point.node == root_node }
    end

    private

    def find_root(nodes, edges)
      nodes - find_bounds(nodes, edges)
    end

    def find_bounds(nodes, edges)
      nodes.select { |node| edges.any? { |edge| edge.right_node == node } }
    end
    
    def wrap_to_points(nodes)
      nodes.map { |node| { "#{node.uuid}" => build_point_for(node) } }
    end

    def build_point_for(node)
      MetaStruct::Graph::Point::Factory.build(node)
    end

    def adjacencies_for(point, right_edges)
      right_edges.map do |edge|
        MetaStruct::Graph::Point::Adjacency.new(
          left_point: point,
          right_point: build_point_for(edge.node)
        )
      end
    end
  end
end
