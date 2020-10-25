# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Factory
  # @return [Array]
  #
  # @api private
  # @since 0.1.0
  NO_NODES = [].freeze

  # @return [Hash]
  #
  # @api private
  # @since 0.1.0
  NO_EDGES = [].freeze

  class << self
    # @option nodes [Array<MetaStruct::Graph::Node>]
    # @option edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph]
    #
    # @api private
    # @since 0.1.0
    def create(nodes: NO_NODES, edges: NO_EDGES)
      validate_attributes(nodes, edges)
      validate_graph_invariants(nodes, edges)
      point_tree = build_point_tree(nodes, edges)
      create_graph(point_tree)
    end

    private

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def validate_attributes(nodes, edges)
      unless nodes.is_a?(::Array) && nodes.all? { |node| node.is_a?(MetaStruct::Graph::Node) }
        raise(MetaStruct::Graph::InvalidNodeListError, <<~ERROR_MESSAGE)
          Node list should be an array of MetaStruct::Graph::Node entities.
        ERROR_MESSAGE
      end

      unless edges.is_a?(::Array) && edges.all? { |edge| edge.is_a?(MetaStruct::Graph::Edge) }
        raise(MetaStruct::Graph::InvalidEdgeListError, <<~ERROR_MESSAGE)
          Edge list should be an array of MetaStruct::Graph::Edge entities.
        ERROR_MESSAGE
      end

      raise(MetaStruct::Graph::EmptyNodeListError, <<~ERROR_MESSAGE) if nodes.empty?
        You should provide nodes for correct graph entity.
      ERROR_MESSAGE

      raise(MetaStruct::Graph::EmptyEdgeListError, <<~ERROR_MESSAGE) if edges.empty?
        You should provide edges for correct graph entity.
      ERROR_MESSAGE

      if nodes.uniq { |node| node.uuid }.size < nodes.size
        raise(MetaStruct::Graph::NodeListDuplicateError, <<~ERROR_MESSAGE)
          You have nodes with duplicated uuids. You should provide nodes without duplicates.
        ERROR_MESSAGE
      end

      if edges.uniq { |edge| [edge.left_node.uuid, edge.right_node.uuid] }.size < edges.size
        raise(
          MetaStruct::Graph::EdgeListDuplicateError,
          "You have duplicated edges (by identical nodes in left and right sides). " \
          "You should provide edges without duplicates."
        )
      end

      unless edges.all? { |edge| nodes.include?(edge.left_node) && nodes.include?(edge.right_node) }
        raise(MetaStruct::Graph::UnprovidedNodeEntityError, <<~ERROR_MESSAGE)
          Some edges has no MetaStruct::Graph::Node entity in node list.
        ERROR_MESSAGE
      end
    end

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def validate_graph_invariants(nodes, edges)
      MetaStruct::Graph::Invariants::All.validate!(nodes, edges)
    end

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def build_point_tree(nodes, edges)
      MetaStruct::Graph::Point::TreeFactory.create(nodes, edges)
    end

    # @param [MetaStruct::Graph::Point]
    # @return [MetaStruct::Graph]
    #
    # @api private
    # @since 0.1.0
    def create_graph(point_tree); end
  end
end
