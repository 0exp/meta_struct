# frozen_string_literal: true

module MetaStruct::Graph::Node::Factory
  # @return [Array]
  NO_LABLES = [].freeze

  # @return [Hash]
  NO_PROPERTIES = {}.freeze

  class << self
    # @option uuid [String, nil]
    # @option labels [Array<String,Symbol>]
    # @option properties [Hash<String|Symbol,Any>]
    # @return [MetaStruct::Graph::Node]
    def create(uuid: generate_uuid, labels: NO_LABLES, properties: NO_PROPERTIES)
      validate_attributes(uuid, labels, properties)

      uuid = prepare_uuid(uuid)
      labels = prepare_labels(labels)
      properties = prepare_properties(properties)

      create_node(uuid, labels, properties)
    end

    # @return [String]
    def generate_uuid
      ::SecureRandom.uuid
    end

    private

    # @param uuid [String, nil]
    # @param labels [Array<String,Symbol>]
    # @param properties [Hash<String|Symbol,Any>]
    # @return [void]
    def validate_attributes(uuid, labels, properties); end

    # @param uuid [String, nil]
    # @return [String]
    def prepare_uuid(uuid); end

    # @param labels [Array<String,Symbol>]
    # @return [Array<String>]
    def prepare_labels(labels); end

    # @param properties [Hash<String|Symbol,Any>]
    # @return [Hash<String,Any>]
    def prepare_properties(properties); end

    # @param uuid [String]
    # @param labels [Array<String>]
    # @param properties [Hash<String,Any>]
    # @return [MetaStruct::Graph::Node]
    def create_node(uuid, labels, properties); end
  end
end
