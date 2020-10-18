# frozen_string_literal: true

class MetaStruct::Graph
  # @return [Class<MetaStruct::Error>]
  Error = Class.new(MetaStruct::Error)

  # @return [Class<MetaStruct::ArgumentError>]
  ArgumentError = Class.new(MetaStruct::ArgumentError)

  # @return [Class<Error>]
  NodeError = Class.new(Error)

  # @return [Class<ArgumentError>]
  NodeArgumentError = Class.new(ArgumentError)

  # @return [Class<NodeArgumentError>]
  InvalidNodeLabelsError = Class.new(NodeArgumentError)

  # @return [Class<NodeArgumentError>]
  InvalidNodePropertiesError = Class.new(NodeArgumentError)
end
