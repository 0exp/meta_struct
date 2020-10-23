# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Node::Factory
  require_relative 'factory/di_container'

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
  AUTO_GENERATED_UUID = nil

  class << self
    # @since 0.1.0
    include SmartCore::Injection(DIContainer)

    # @since 0.1.0
    import({ uuid_generator: 'uuid_generator' }, bind: :dynamic, access: :private)

    # @option uuid [String, nil]
    # @option labels [Array<String,Symbol>]
    # @option properties [Hash<String|Symbol,Any>]
    # @return [MetaStruct::Graph::Node]
    #
    # @api private
    # @since 0.1.0
    def create(uuid: AUTO_GENERATED_UUID, labels: NO_LABELS, properties: NO_PROPERTIES, root: false)
      validate_attributes(uuid, labels, properties, root)

      uuid = prepare_uuid(uuid)
      labels = prepare_labels(labels)
      properties = prepare_properties(properties)

      create_node(uuid, labels, properties, root)
    end

    private

    # @param uuid [String, nil]
    # @param labels [Array<String,Symbol>]
    # @param properties [Hash<String|Symbol,Any>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def validate_attributes(uuid, labels, properties, root)
      unless labels.is_a?(::Array)
        raise(MetaStruct::Graph::InvalidNodeLabelsError, <<~ERROR_MESSAGE)
          Node labels collection should be a type of Array of strings.
        ERROR_MESSAGE
      end

      unless labels.all? { |label| label.is_a?(::String) || label.is_a?(::Symbol) }
        raise(MetaStruct::Graph::InvalidNodeLabelsError, <<~ERROR_MESSAGE)
          Each node's label should be a type of string or symbol.
        ERROR_MESSAGE
      end

      unless properties.is_a?(::Hash)
        raise(MetaStruct::Graph::InvalidNodePropertiesError, <<~ERROR_MESSAGE)
          Node properties collection should be a type of Hash.
        ERROR_MESSAGE
      end

      unless properties.keys.all? { |key| key.is_a?(::String) || key.is_a?(::Symbol) }
        raise(MetaStruct::Graph::InvalidNodePropertiesError, <<~ERROR_MESSAGE)
          Node property keys should be a type of string or symbol.
        ERROR_MESSAGE
      end

      unless root.is_a?(::TrueClass) || root.is_a?(::FalseClass)
        raise(MetaStruct::Graph::NodeArgumentError, <<~ERROR_MESSAGE)
          Node root atribute should be a type of Boolean 
        ERROR_MESSAGE
      end
    end

    # @param uuid [String, nil]
    # @return [String]
    #
    # @api private
    # @since 0.1.0
    def prepare_uuid(uuid)
      uuid == nil ? uuid_generator.call : uuid
    end

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

    # @param uuid [String]
    # @param labels [Array<String>]
    # @param properties [Hash<String,Any>]
    # @return [MetaStruct::Graph::Node]
    #
    # @api private
    # @since 0.1.0
    def create_node(uuid, labels, properties, root)
      MetaStruct::Graph::Node.new(
        uuid: uuid, 
        labels: labels, 
        properties: properties,
        root: root
      )
    end
  end
end
