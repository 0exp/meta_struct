# frozen_string_literal: true

module MetaStruct::Graph::Points
  class BuildTree
    class << self
      def call(nodes, edges)
        new(nodes, edges).call
      end
    end

    private_class_method :new

    def initialize(nodes, edges)
      @nodes = nodes
      @edges = edges
    end

    def call
      roots = FindRoot.call(nodes, edges)

      tree_roots = roots.map(&method(:build_point))
      build(tree_roots)
    end

    private

    attr_reader :nodes
    attr_reader :edges

    def build_point(node)
      node_edges = edges.select { |edge| edge.left_node.uuid == node.uuid }

      MetaStruct::Graph::Point.new(node, node_edges)
    end

    def find_children_for(node)
      edges.map do |edge|
        build_point(edge.right_node) if edge.left_node.uuid == node.uuid
      end.compact
    end

    def build(root_points)
      root_points.each do |root_point|
        node = root_point.node

        root_point.add_children(find_children_for(node))

        if root_point.children.any?
          build(root_point.children)
        end
      end
    end
  end
end