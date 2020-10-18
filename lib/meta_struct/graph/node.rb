# frozen_string_literal: true

class MetaStruct::Graph::Node
  require_relative 'node/factory'

  # @return [Hash<String,Any>]
  attr_reader :properties

  # @return [Array<String>]
  attr_reader :labels

  # @return [String]
  attr_reader :uuid

  # @option uuid [String]
  # @option labels [Array<String>]
  # @option properties [Hash<String,Any>]
  # @return [void]
  def initialize(uuid:, labels:, properties:,)
    @uuid = uuid
    @lables = lables
    @properties = properties
  end
end
