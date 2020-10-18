# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Edge::Factory
  # @return [Integer]
  #
  # @api private
  # @since 0.1.0
  NO_WEIGHT = 0

  # @return [Array]
  #
  # @api private
  # @since 0.1.0
  NO_LABELS = [].freeze

  # @return [Hash]
  #
  # @api private
  # @since 0.1.0
  NO_PROPERTIES = {}.freeze

  # @return [nil]
  #
  # @api private
  # @since 0.1.0
  NO_LEFT_NODE = nil

  # @return [nil]
  #
  # @api private
  # @since 0.1.0
  NO_RIGHT_NODE = nil

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
    # rubocop:disable Layout/LineLength
    def create(left_node: NO_LEFT_NODE, right_node: NO_RIGHT_NODE, labels: NO_WEIGHT, properties: NO_PROPERTIES, weight: NO_WEIGHT)
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
    #
    # @api private
    # @since 0.1.0
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/PerceivedComplexity
    def validate_attributes(left_node, right_node, labels, properties, weight)
      raise(MetaStruct::Graph::EdgeNodeInsufficiencyError, <<~ERROR_MESSAGE) if left_node == nil
        Left edge node is missing: you should provide both left and right nodes.
      ERROR_MESSAGE

      raise(MetaStruct::Graph::EdgeNodeInsufficiencyError, <<~ERROR_MESSAGE) if right_node == nil
        Right edge node is missing: you should provide both left and right nodes.
      ERROR_MESSAGE

      unless left_node.is_a?(MetaStruct::Graph::Node)
        raise(MetaStruct::Graph::InvalidEdgeNodeError, <<~ERROR_MESSAGE)
          Left edge Node should be a type of MetaStruct::Graph::Node.
        ERROR_MESSAGE
      end

      unless right_node.is_a?(MetaStruct::Graph::Node)
        raise(MetaStruct::Graph::InvalidEdgeNodeError, <<~ERROR_MESSAGE)
          Right edge Node should be a type of MetaStruct::Graph::Node.
        ERROR_MESSAGE
      end

      unless labels.is_a?(::Array)
        raise(MetaStruct::Graph::InvalidEdgeLabelsError, <<~ERROR_MESSAGE)
          Edge labels collection should be a type of Array of strings.
        ERROR_MESSAGE
      end

      unless labels.all? { |label| label.is_a?(::String) || label.is_a?(::Symbol) }
        raise(MetaStruct::Graph::InvalidEdgeLabelsError, <<~ERROR_MESSAGE)
          Each edge's label should be a type of string or symbol.
        ERROR_MESSAGE
      end

      unless properties.is_a?(::Hash)
        raise(MetaStruct::Graph::InvalidEdgePropertiesError, <<~ERROR_MESSAGE)
          Edge properties collection should be a type of Hash.
        ERROR_MESSAGE
      end

      unless properties.keys.all? { |key| key.is_a?(::String) || key.is_a?(::Symbol) }
        raise(MetaStruct::Graph::InvalidEdgePropertiesError, <<~ERROR_MESSAGE)
          Edge property keys should be a type of string or symbol.
        ERROR_MESSAGE
      end

      unless weight.is_a?(::Integer)
        raise(MetaStruct::Graph::InvalidEdgeWeightError, <<~ERROR_MESSAGE)
          Edge weight should be a type of integer.
        ERROR_MESSAGE
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/PerceivedComplexity

    # @param labels [Array<String,Symbol>]
    # @return [Array<String>]
    #
    # @api private
    # @since 0.1.0
    def prepare_labels(labels)
      labels.map(&:to_s).tap(&:freeze)
    end

    # @param properties [Hash<String|Symbol,Any>]
    # @return [Hash<String,Any>]
    #
    # @api private
    # @since 0.1.0
    def prepare_properties(properties)
      properties.transform_keys(&:to_s).tap(&:freeze)
    end

    # @param left_node [MetaStruct::Graph::Node]
    # @param right_node [MetaStruct::Graph::Node]
    # @param labels [Array<String>]
    # @param properties [Hash<String,Any>]
    # @param weight [Integer]
    # @return [MetaStruct::Graph::Edge]
    #
    # @api private
    # @since 0.1.0
    def create_edge(left_node, right_node, labels, properties, weight)
      MetaStruct::Graph::Edge.new(
        left_node: left_node,
        right_node: right_node,
        labels: labels,
        properties: properties,
        weight: weight
      )
    end
  end
end
