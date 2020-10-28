# frozen_string_literal: true

# @api public
# @since 0.1.0
class MetaStruct::Graph::Edge::Serializer
  extend Forwardable

  # @since 0.1.0
  include SmartCore::Injection(MetaStruct::DIContainer)

  # @since 0.1.0
  import({ node_serializer: 'nodes.serializer' }, bind: :dynamic, access: :private)

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

  attr_reader :edge

  def_delegators :edge, :left_node, :labels, :right_node, :properties, :weight

  def serialize_node(node)
    node_serializer.new(node).call
  end
end
