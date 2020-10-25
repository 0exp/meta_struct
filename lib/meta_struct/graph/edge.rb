# frozen_string_literal: true

# @api public
# @since 0.1.0
class MetaStruct::Graph::Edge
  require_relative 'edge/factory'

  class << self
    # @option left_node [MetaStruct::Graph::Node]
    # @option right_node [MetaStruct::Graph::Node]
    # @option labels [Array<String,Symbol>]
    # @option properties [Hash<String|Symbol,Any>]
    # @option weight [Integer]
    # @return [MetaStruct::Graph::Edge]
    #
    # @api private
    # @since 0.1.0
    def create(
      left_node: Factory::NO_LEFT_NODE,
      right_node: Factory::NO_RIGHT_NODE,
      labels: Factory::NO_LABELS,
      properties: Factory::NO_PROPERTIES,
      weight: Factory::NO_WEIGHT
    )
      Factory.create(
        left_node: left_node,
        right_node: right_node,
        labels: labels,
        properties: properties,
        weight: weight
      )
    end
  end

  # @return [Array<String>]
  #
  # @api public
  # @since 0.1.0
  attr_reader :labels

  # @return [Hash<String,Any>]
  #
  # @api public
  # @since 0.1.0
  attr_reader :properties

  # @return [MetaStruct::Graph::Node]
  #
  # @api public
  # @since 0.1.0
  attr_reader :left_node

  # @return [MetaStruct::Graph::Node]
  #
  # @api public
  # @since 0.1.0
  attr_reader :right_node

  # @return [Integer]
  #
  # @api public
  # @since 0.1.0
  attr_reader :weight

  # @option left_node [MetaStruct::Graph::Node]
  # @option right_node [MetaStruct::Graph::Node]
  # @option labels [Array<String>]
  # @option properties [Hash<String,Any>]
  # @option weight [Integer]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(left_node:, right_node:, labels:, properties:, weight:)
    @left_node = left_node
    @right_node = right_node
    @labels = labels
    @properties = properties
    @weight = weight
  end
end
