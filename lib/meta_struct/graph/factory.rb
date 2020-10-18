# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Factory
  # @return [Array]
  #
  # @api private
  # @since 0.1.0
  NO_NODES = [].freeze

  # @return [Hash]
  #
  # @api private
  # @since 0.1.0
  NO_EDGES = [].freeze

  class << self
    # @option nodes [Array<MetaStruct::Graph::Node>]
    # @option edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph]
    #
    # @api private
    # @since 0.1.0
    def create(nodes: NO_NODES, edges: NO_EDGES)
      validate_attributes(nodes, edges)
      point_tree = build_point_tree(nodes, edges)
      create_graph(point_tree)
    end

    private

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def validate_attributes(nodes, edges); end

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def build_point_tree(nodes, edges); end

    # @param [MetaStruct::Graph::Point]
    # @return [MetaStruct::Graph]
    #
    # @api private
    # @since 0.1.0
    def create_graph(point_tree); end
  end
end
