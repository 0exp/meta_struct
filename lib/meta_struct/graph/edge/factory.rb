# frozen_string_literal: true

module MetaStruct::Graph::Edge::Factory
  class << self
    # @option left_node [MetaStruct::Graph::Node]
    # @option right_node [MetaStruct::Graph::Node]
    # @option labels [Array<String>]
    # @option properties [Hash<String,Any>]
    # @return [MetaStruct::Graph::Edge]
    def create(left_node:, right_node:, labels:, properties:)
    end
  end
end
