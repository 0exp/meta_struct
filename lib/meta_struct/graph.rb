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
  require_relative 'graph/serializer'

  # @since 0.1.0
  include SmartCore::Injection(::MetaStruct::DIContainer)

  # @since 0.1.0
  import({ graph_serializer: 'graph.serializer' }, bind: :dynamic, access: :private)

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

  # @return [Array<MetaStruct::Graph::Node>]
  #
  # @api public
  # @since 0.1.0
  attr_reader :nodes

  # @return [Array<MetaStruct::Graph::Edge>]
  #
  # @api public
  # @since 0.1.0
  attr_reader :edges

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
  def find_point(node_uuid)
    Algorithms::FindPoint.call(self, node_uuid)
  end

  # @option from_uuid [String]
  # @param iterator [Block]
  # @return [void]
  #
  # @api public
  # @since 0.1.0
  def traverse(from_uuid: nil, &iterator)
    Algorithms::GraphTraversal.traverse(self, from_uuid, &iterator)
  end

  # @return [Hash]
  #
  # @api public
  # @since 0.1.0
  def serialize
    serializer.call
  end

  # @return [Json]
  #
  # @api public
  # @since 0.1.0
  def to_json(*_args)
    serializer.to_json
  end

  private

  # @return [MetaStruct::Graph::Serializer]
  #
  # @api private
  # @since 0.1.0
  def serializer
    graph_serializer.new(self)
  end
end
