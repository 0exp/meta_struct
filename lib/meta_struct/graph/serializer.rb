# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct
  class Graph::Serializer
    # @since 0.1.0
    extend Forwardable

    # @since 0.1.0
    include SmartCore::Injection(::MetaStruct::DIContainer)

    # @since 0.1.0
    import({ node_serializer: 'graph.nodes.serializer' }, bind: :dynamic, access: :private)

    # @param graph [MetaStruct::Graph]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def initialize(graph)
      @graph = graph
    end

    # @return [Hash]
    #
    # @api public
    # @since 0.1.0
    def call
      {
        root: serialize_node(root.node),
        nodes: serialize_nodes,
        edges: serialize_edges
      }
    end

    # @return [Json]
    #
    # @api public
    # @since 0.1.0
    def_delegators :call, :to_json

    private

    # @return [MetaStruct::Graph]
    #
    # @api private
    # @since 0.1.0
    attr_reader :graph

    # @api private
    # @since 0.1.0
    def_delegators :graph, :root, :nodes, :edges

    # @param node [MetaStruct::Graph::Node]
    # @return [Hash]
    #
    # @api private
    # @since 0.1.0
    def serialize_node(node)
      node_serializer.new(node).call
    end

    # @param edge [MetaStruct::Graph::Edge]
    # @return [Hash]
    #
    # @api private
    # @since 0.1.0
    def serialize_edge(edge)
      {
        left_node: edge.left_node.uuid,
        right_node: edge.right_node.uuid,
        labels: edge.labels,
        properties: edge.properties,
        weight: edge.weight
      }
    end

    # @return [Array<Hash>]
    #
    # @api private
    # @since 0.1.0
    def serialize_nodes
      nodes.map { |node| serialize_node(node) }
    end

    # @return [Array<Hash>]
    #
    # @api private
    # @since 0.1.0
    def serialize_edges
      edges.map { |edge| serialize_edge(edge) }
    end
  end
end
