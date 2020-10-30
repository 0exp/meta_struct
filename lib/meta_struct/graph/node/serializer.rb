# frozen_string_literal: true

# @api public
# @since 0.1.0
class MetaStruct::Graph::Node::Serializer
  # @since 0.1.0
  extend Forwardable

  # @param node [MetaStruct::Graph::Node]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(node)
    @node = node
  end

  # @return [Hash]
  #
  # @api public
  # @since 0.1.0
  def call
    {
      uuid: uuid,
      labels: labels,
      properties: properties
    }
  end

  # @return [Json]
  #
  # @api public
  # @since 0.1.0
  def_delegators :call, :to_json

  private

  # @return [MetaStruct::Graph::Node]
  #
  # @api private
  # @since 0.1.0
  attr_reader :node

  # @api private
  # @since 0.1.0
  def_delegators :node, :uuid, :labels, :properties
end
