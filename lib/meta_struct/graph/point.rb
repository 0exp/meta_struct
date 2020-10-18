# frozen_string_literal: true

class MetaStruct::Graph::Point
  # @return [MetaStruct::Graph::Node]
  attr_reader :node

  # @return [Array<MetaStruct::Graph::Edge>]
  attr_reader :edges

  # @param node [MetaStruct::Graph::Node]
  # @param edges [Array<MetaStruct::Graph::Edge>]
  # @return [void]
  def initialize(node, edges)
    @node = node
    @edges = edges
  end
end
