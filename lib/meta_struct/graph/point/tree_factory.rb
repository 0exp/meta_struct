# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Point::TreeFactory
  class << self
    # @since 0.1.0
    include SmartCore::Injection(::MetaStruct::DIContainer)

    # @since 0.1.0
    import(
      { find_root_nodes: 'graph.algorithms.find_root_nodes' },
      bind: :dynamic,
      access: :private
    )

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def create(nodes, edges)
      wrrapped_points = wrap_to_points(nodes)
      root_node = find_root_nodes.call(nodes, edges).first

      wrrapped_points.each do |point|
        right_edges = edges.select { |edge| edge.left_node.uuid == point.node.uuid }

        next unless right_edges.any?

        point.adjacencies = adjacencies_for(point, right_edges, wrrapped_points)
      end

      wrrapped_points.detect { |point| point.node == root_node }
    end

    private

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @return [Array<MetaStruct::Graph::Point>]
    #
    # @api private
    # @since 0.1.0
    def wrap_to_points(nodes)
      nodes.map { |node| build_point_for(node) }
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
    # @param edges [Array<MetaStruct::Graph::Point>]
    # @return [Array<MetaStruct::Graph::Point::Adjacency>]
    #
    # @api private
    # @since 0.1.0
    def adjacencies_for(point, right_edges, points)
      right_edges.map do |edge|
        right_point = points.detect { |r_point| r_point.node == edge.right_node }

        MetaStruct::Graph::Point::Adjacency.new(point, right_point, edge)
      end
    end
  end
end
