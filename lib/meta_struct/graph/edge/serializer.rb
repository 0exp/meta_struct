# frozen_string_literal: true

# @api public
# @since 0.1.0
class MetaStruct::Graph::Edge::Serializer
  # @since 0.1.0
  extend Forwardable

  # @since 0.1.0
  include SmartCore::Injection(MetaStruct::DIContainer)

  # @since 0.1.0
  import({ node_serializer: 'nodes.serializer' }, bind: :dynamic, access: :private)

  # @param edge [MetaStruct::Graph::Edge]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(edge)
    @edge = edge
  end

  # @return [Hash]
  #
  # @api public
  # @since 0.1.0
  def call
    {
      left_node: serialize_node(left_node),
      right_node: serialize_node(right_node),
      labels: labels,
      properties: properties,
      weight: weight
    }
  end

  # @return [Json]
  #
  # @api public
  # @since 0.1.0
  def_delegators :call, :to_json

  private

  # @return [MetaStruct::Graph::Edge]
  #
  # @api private
  # @since 0.1.0
  attr_reader :edge

  # @api private
  # @since 0.1.0
  def_delegators :edge, :left_node, :labels, :right_node, :properties, :weight

  # @param node [MetaStruct::Graph::Node]
  # @return [Hash]
  #
  # @api private
  # @since 0.1.0
  def serialize_node(node)
    node_serializer.new(node).call
  end
end
