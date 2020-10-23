# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Algorithms::FindNode
  class << self
    # @param graph [MetaStruct::Graph]
    # @param node_uuid [String]
    # @return [MetaStruct::Graph::Point, nil]
    #
    # @api private
    # @since 0.1.0
    def call(graph, node_uuid)
      new(graph).find
    end
  end

  private_class_method :new

  def initialize(graph, node_uuid)
    @graph = graph
    @node_uuid = node_uuid
  end

  def find
  end

  private

  attr_reader :graph
  attr_reader :node_uuid
end
