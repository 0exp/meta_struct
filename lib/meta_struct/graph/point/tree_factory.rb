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
      points = build_points(nodes)
      build_and_append_adjacencies(points, edges)
      find_root_point(points, edges)
    end

    private

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @return [Array<MetaStruct::Graph::Point>]
    #
    # @api private
    # @since 0.1.0
    def build_points(nodes)
      nodes.map { |node| MetaStruct::Graph::Point::Factory.create(node) }
    end

    # @param points [Array<MetaStruct::Graph::Point>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def build_and_append_adjacencies(points, edges)
      points.each do |point|
        # 1 - find all point edges
        point_edges = edges.select { |edge| edge.left_node == point.node }
        # 2 - build point adjancencies for corresponding point edges
        point_adjacencies = point_edges.map do |point_edge|
          left_point = point
          right_point = points.find { |r_point| point_edge.right_node == r_point.node }
          MetaStruct::Graph::Point::Adjacency.new(point_edge, left_point, right_point)
        end
        # 3 - append adjacencies
        MetaStruct::Graph::Point::Factory.append_adjacencies(point, point_adjacencies)
      end
    end

    # @param points [Array<MetaStruct::Graph::Point>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def find_root_point(points, edges)
      points.find { |point| edges.all? { |edge| edge.right_node != point.node } }
    end
  end
end
