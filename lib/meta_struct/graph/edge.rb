# frozen_string_literal: true

class MetaStruct::Graph::Edge
  require_relative 'edge/factory'

  class << self
    # @option left_node [MetaStruct::Graph::Node]
    # @option right_node [MetaStruct::Graph::Node]
    # @option labels [Array<String,Symbol>]
    # @option properties [Hash<String|Symbol,Any>]
    # @option weight [Integer]
    # @return [MetaStruct::Graph::Edge]
    # rubocop:disable Layout/LineLength
    def create(left_node:, right_node:, labels: Factory::NO_LABELS, properties: Factory::NO_PROPERTIES, weight: Factory::NO_WEIGHT)
      Factory.create(left_node: left_node, right_node: right_node, labels: labels, properties: properties, weight: weight)
    end
    # rubocop:enable Layout/LineLength
  end

  # @return [Array<String>]
  attr_reader :labels

  # @return [Hash<String,Any>]
  attr_reader :properties

  # @return [MetaStruct::Graph::Node]
  attr_reader :left_node

  # @return [MetaStruct::Graph::Node]
  attr_reader :right_node

  # @return [Integer]
  attr_reader :weight

  # @option left_node [MetaStruct::Graph::Node]
  # @option right_node [MetaStruct::Graph::Node]
  # @option labels [Array<String>]
  # @option properties [Hash<String,Any>]
  # @return [void]
  def initialize(left_node:, right_node:, labels:, properties:, weight:)
    @left_node = left_node
    @right_node = right_node
    @labels = labels
    @properties = properties
  end
end
