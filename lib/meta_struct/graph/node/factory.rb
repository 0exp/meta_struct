# frozen_string_literal: true

module MetaStruct::Graph::Node::Factory
  class << self
    # @option uuid [String, Nil]
    # @option labels [Array<String>]
    # @option properties [Hash<String|Symbol,Any>]
    # @return [MetaStruct::Graph::Node]
    def create(uuid:, labels:, properties:)
      validate_attributes(uuid, labels, properties)

      uuid = prepare_uuid(uuid)
      labels = prepare_labels(labels)
      properties = prepare_properties(properties)

      create_node(uuid, labels, properties)
    end

    private

    # @param uuid [String]
    # @param labels [Array<String>]
    # @param properties [Hash<String|Symbol,Any>]
    # @return [void]
    def validate_attributes(uuid, labels, properties); end

    # @param uuid [String]
    # @return [String]
    def prepare_uuid(uuid); end

    # @param labels [Array<String>]
    # @return [Array<String>]
    def prepare_labels(labels); end

    # @param properties [Hash<String|Symbol,Any>]
    # @return [Hash<String,Any>]
    def prepare_properties(properties); end

    # @param uuid [String]
    # @param labels [Array<String>]
    # @param properties [Hash<String|Symbol,Any>]
    # @return [MetaStruct::Graph::Node]
    def create_node(uuid, labels, properties); end
  end
end
