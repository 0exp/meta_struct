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

  # @return [Class<MetaStruct::Graph::Error>]
  #
  # @api public
  # @since 0.1.0
  NodeError = Class.new(Error)

  # @return [Class<MetaStruct::Graph::ArgumentError>]
  #
  # @api public
  # @since 0.1.0
  NodeArgumentError = Class.new(ArgumentError)

  # @return [Class<MetaStruct::Graph::NodeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidNodeLabelsError = Class.new(NodeArgumentError)

  # @return [Class<MetaStruct::Graph::NodeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidNodePropertiesError = Class.new(NodeArgumentError)

  # @return [Class<MetaStruct::Graph::Error>]
  #
  # @api public
  # @since 0.1.0
  EdgeError = Class.new(Error)

  # @return [Class<MetaStruct::Graph::ArgumentError>]
  #
  # @api public
  # @since 0.1.0
  EdgeArgumentError = Class.new(ArgumentError)

  # @return [Class<MetaStruct::Graph::EdgeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidEdgeWeightError = Class.new(EdgeArgumentError)

  # @return [Class<MetaStruct::Graph::EdgeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidEdgeNodeError = Class.new(EdgeArgumentError)

  # @return [Class<MetaStruct::Graph::EdgeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  EdgeNodeInsufficiencyError = Class.new(EdgeArgumentError)

  # @return [Class<MetaStruct::Graph::EdgeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidEdgeLabelsError = Class.new(EdgeArgumentError)

  # @return [Class<MetaStruct::Graph::EdgeArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidEdgePropertiesError = Class.new(EdgeArgumentError)

  # @return [Class<MetaStruct::Graph::Error>]
  #
  # @api public
  # @since 0.1.0
  GraphError = Class.new(Error)

  # @return [Class<MetaStruct::Graph::ArgumentError>]
  #
  # @api public
  # @since 0.1.0
  GraphArgumentError = Class.new(ArgumentError)

  # @return [Class<MetaStruct::Graph::GraphArgumentError>]
  #
  # @api public
  # @since 0.1.0
  EmptyNodeListError = Class.new(GraphArgumentError)

  # @return [Class<MetaStruct::Graph::GraphArgumentError>]
  #
  # @api public
  # @since 0.1.0
  EmptyEdgeListError = Class.new(GraphArgumentError)

  # @return [Class<MetaStruct::Graph::GraphArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidNodeListError = Class.new(GraphArgumentError)

  # @return [Class<MetaStruct::Graph::GraphArgumentError>]
  #
  # @api public
  # @since 0.1.0
  InvalidEdgeListError = Class.new(GraphArgumentError)

  # @return [Class<MetaStruct::Graph::GraphArgumentError>]
  #
  # @api public
  # @since 0.1.0
  UnprovidedNodeEntityError = Class.new(GraphArgumentError)

  # @return [Class<MetaStruct::Graph::GraphArgumentError>]
  #
  # @api public
  # @since 0.1.0
  NodeListDuplicateError = Class.new(GraphArgumentError)

  # @return [Class<MetaStruct::Graph::GraphArgumentError>]
  #
  # @api public
  # @since 0.1.0
  EdgeListDuplicateError = Class.new(GraphArgumentError)

  # @return [Class<MetaStruct::Graph::GraphError>]
  #
  # @api public
  # @since 0.1.0
  InvariantError = Class.new(GraphError)

  # @return [Class<MetaStruct::Graph::InvariantError>]
  #
  # @api public
  # @since 0.1.0
  NonConnectedNodeInvariantError = Class.new(InvariantError)

  # @return [Class<MetaStruct::Graph::InvariantError>]
  #
  # @api public
  # @since 0.1.0
  MoreThanOneRootInvariantError = Class.new(InvariantError)

  # @return [Class<MetaStruct::Graph::InvariantError>]
  #
  # @api public
  # @since 0.1.0
  RootNotFoundInvariantError = Class.new(InvariantError)

  # @return [Class<MetaStruct::Graph::InvariantError>]
  #
  # @api public
  # @since 0.1.0
  NoExitNodeInvariantError = Class.new(InvariantError)

  # @return [Class<MetaStruct::Graph::InvariantError>]
  #
  # @api public
  # @since 0.1.0
  class GraphHasCyclesInvariantError < InvariantError
    # @return [MetaStruct::Graph]
    #
    # @api public
    # @since 0.1.0
    attr_reader :graph

    # @return [Array<MetaStruct:Graph::Point>]
    #
    # @api public
    # @since 0.1.0
    attr_reader :cycled_points

    # @param message [String]
    # @option graph [MetaStruct::Graph]
    # @option cycled_points [Array<MetaStruct:Graph::Point>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def initialize(message, graph:, cycled_points:)
      super(message)
      @cycled_points = cycled_points
    end
  end
end
