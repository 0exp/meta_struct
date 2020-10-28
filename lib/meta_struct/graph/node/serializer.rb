# frozen_string_literal: true

# @api public
# @since 0.1.0
class MetaStruct::Graph::Node::Serializer
  extend Forwardable

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

  attr_reader :node

  def_delegators :node, :uuid, :labels, :properties
end
