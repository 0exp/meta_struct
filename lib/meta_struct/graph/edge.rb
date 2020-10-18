# frozen_string_literal: true

class MetaStruct::Graph::Edge
  require_relative 'edge/factory'

  # @return [Array<String>]
  attr_reader :labels

  # @return [Hash<String,Any>]
  attr_reader :properties

  # @return [MetaStruct::Graph::Node]
  attr_reader :left_node

  # @return [MetaStruct::Graph::Node]
  attr_reader :right_node

  # @option left_node [MetaStruct::Graph::Node]
  # @option right_node [MetaStruct::Graph::Node]
  # @option labels [Array<String>]
  # @option properties [Hash<String,Any>]
  # @return [void]
  def initialize(left_node:, right_node:, labels:, properties:)
    @left_node = left_node
    @right_node = right_node
    @labels = labels
    @properties = properties
  end
end
