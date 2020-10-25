# frozen_string_literal: true

# @api public
# @since 0.1.0
class MetaStruct::Graph
  require_relative 'graph/errors'
  require_relative 'graph/node'
  require_relative 'graph/edge'
  require_relative 'graph/point'
  require_relative 'graph/invariants'
  require_relative 'graph/factory'
  require_relative 'graph/algorithms'

  class << self
    # @option nodes [Array<MetaStruct::Graph::Node>]
    # @option edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph]
    #
    # @api public
    # @since 0.1.0
    def create(nodes: Factory::NO_NODES, edges: Factory::NO_EDGES)
      Factory.create(nodes: nodes, edges: edges)
    end
  end

  # @return [MetaStruct::Graph::Point]
  #
  # @api public
  # @since 0.1.0
  attr_reader :root

  # @param root [MetaStruct::Graph::Point]
  # @param nodes [Array<MetaStruct::Graph::Node>]
  # @param edges [Array<MetaStruct::Graph::Edge>]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(root, nodes, edges)
    @root = root
    @nodes = nodes
    @edges = edges
  end

  # @param node_uuid [String]
  # @return [MetaStruct::Graph::Point]
  #
  # @api public
  # @since 0.1.0
  def find_node(node_uuid)
    Algorithms::FindNode.call(self, node_uuid)
  end

  # @param iterator [Block]
  # @return [void]
  #
  # @api public
  # @since 0.1.0
  def traverse(&iterator)
    Algorithms::GraphTraversal.traverse(self, &iterator)
  end
end
