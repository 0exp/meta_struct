# frozen_string_literal: true

class MetaStruct::Graph
  # @return [Class<MetaStruct::Error>]
  #
  # @api public
  # @since 0.1.0
  Error = Class.new(MetaStruct::Error)

  # @return [Class<MetaStruct::ArgumentError>]
  #
  # @api public
  # @since 0.1.0
  ArgumentError = Class.new(MetaStruct::ArgumentError)

  # @return [Class<Error>]
  #
  # @api public
  # @since 0.1.0
  NodeError = Class.new(Error)

  # @return [Class<ArgumentError>]
  #
  # @api public
  # @since 0.1.0
  NodeArgumentError = Class.new(ArgumentError)

  # @return [Class<NodeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidNodeLabelsError = Class.new(NodeArgumentError)

  # @return [Class<NodeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidNodePropertiesError = Class.new(NodeArgumentError)

  # @return [Class<Error>]
  #
  # @api public
  # @since 0.1.0
  EdgeError = Class.new(Error)

  # @return [Class<ArgumentError>]
  #
  # @api public
  # @since 0.1.0
  EdgeArgumentError = Class.new(ArgumentError)

  # @return [Class<EdgeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidEdgeWeightError = Class.new(EdgeArgumentError)

  # @return [Class<EdgeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidEdgeNodeError = Class.new(EdgeArgumentError)

  # @return [Class<EdgeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  EdgeNodeInsufficiencyError = Class.new(EdgeArgumentError)

  # @return [Class<EdgeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidEdgeLabelsError = Class.new(EdgeArgumentError)

  # @return [Class<EdgeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidEdgePropertiesError = Class.new(EdgeArgumentError)
end
