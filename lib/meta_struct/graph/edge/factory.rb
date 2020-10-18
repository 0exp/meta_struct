# frozen_string_literal: true

module MetaStruct::Graph::Edge::Factory
  # @return [Integer]
  NO_WEIGHT = 0

  # @return [Array]
  NO_LABELS = [].freeze

  # @return [Hash]
  NO_PROPERTIES = {}.freeze

  class << self
    # @option left_node [MetaStruct::Graph::Node]
    # @option right_node [MetaStruct::Graph::Node]
    # @option labels [Array<String,Symbol>]
    # @option properties [Hash<String|Symbol,Any>]
    # @option weight [Integer]
    # @return [MetaStruct::Graph::Edge]
    # rubocop:disable Layout/LineLength
    def create(left_node:, right_node:, labels: NO_WEIGHT, properties: NO_PROPERTIES, weight: NO_WEIGHT)
      validate_attributes(left_node, right_node, labels, properties, weight)

      labels = prepare_labels(labels)
      properties = prepare_properties(properties)

      create_edge(left_node, right_node, labels, properties, weight)
    end
    # rubocop:enable Layout/LineLength

    private

    # @param left_node [MetaStruct::Graph::Node]
    # @param right_node [MetaStruct::Graph::Node]
    # @param labels [Array<String,Symbol>]
    # @param properties [Hash<String|Symbol,Any>]
    # @param weight [Integer]
    # @return [void]
    def validate_attributes(left_node, right_node, labels, properties, weight); end

    # @param labels [Array<String,Symbol>]
    # @return [Array<String>]
    def prepare_labels(labels); end

    # @param properties [Hash<String|Symbol,Any>]
    # @return [Hash<String,Any>]
    def prepare_properties(properties); end

    # @param left_node [MetaStruct::Graph::Node]
    # @param right_node [MetaStruct::Graph::Node]
    # @param labels [Array<String>]
    # @param properties [Hash<String,Any>]
    # @param weight [Integer]
    # @return [MetaStruct::Graph::Edge]
    def create_edge(left_node, right_node, labels, properties, weight); end
  end
end
