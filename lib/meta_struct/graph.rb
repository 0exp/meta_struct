# frozen_string_literal: true

class MetaStruct::Graph
  require_relative 'graph/node'
  require_relative 'graph/edge'
  require_relative 'graph/point'
  require_relative 'graph/factory'

  # @return [MetaStruct::Graph::Point]
  attr_reader :root

  # @param root [MetaStruct::Graph::Point]
  # @return [void]
  def initialize(root)
    @root = root
  end
end
