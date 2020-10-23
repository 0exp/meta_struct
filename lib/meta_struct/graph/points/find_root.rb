# frozen_string_literal: true

module MetaStruct::Graph::Points
  class FindRoot
    class << self
      def call(nodes, edges)
        new(nodes, edges).find
      end
    end

    private_class_method :new

    def initialize(nodes, edges)
      @nodes = nodes
      @edges = edges
    end

    def find
      roots = left_nodes.delete_if { |node| right_node_uuids.include?(node.uuid) }

      roots + unrelated_nodes
    end

    private

    attr_reader :nodes
    attr_reader :edges

    def left_nodes
      edges.map(&:left_node).uniq
    end

    def right_nodes
      edges.map(&:right_node).uniq
    end

    def right_node_uuids
      right_nodes.map(&:uuid)
    end

    def left_node_uuids
      left_nodes.map(&:uuid)
    end

    def unrelated_nodes
      nodes.select do |node|
        uuid = node.uuid

        !left_node_uuids.include?(uuid) && !right_node_uuids.include?(uuid)
      end
    end
  end
end