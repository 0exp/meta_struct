# frozen_string_literal: true

class MetaStruct::Graph
  require_relative 'graph/errors'
  require_relative 'graph/node'
  require_relative 'graph/edge'
  require_relative 'graph/point'
  require_relative 'graph/factory'

  class << self
    # @option nodes [Array<MetaStruct::Graph::Node>]
    # @option edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph]
    def create(nodes: Factpry::NO_NODES, edges: Factory::NO_EDGES); end
  end

  # @return [MetaStruct::Graph::Point]
  attr_reader :root

  # @param root [MetaStruct::Graph::Point]
  # @return [void]
  def initialize(root)
    @root = root
  end
end
