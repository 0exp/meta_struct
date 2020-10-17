# frozen_string_literal: true

class MetaStruct::Graph::Node
  require_relative 'node/factory'

  # @return [Hash<String,Any>]
  attr_reader :properties

  # @return [Array<String>]
  attr_reader :labels

  # @return [String]
  attr_reader :uuid

  # @return [Array<MetaStruct::Graph::Edge>]
  attr_reader :edges

  # @param uuid [String]
  # @param labels [Array<String>]
  # @param properties [Hash<String,Any>]
  # @return [void]
  def initialize(uuid, labels, properties)
    @uuid = uuid
    @lables = lables
    @properties = properties
  end
end
