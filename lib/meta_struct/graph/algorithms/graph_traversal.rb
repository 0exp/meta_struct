# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Algorithms::GraphTraversal
  class << self
    # @param graph [MetaStruct::Graph]
    # @param iterator [Block]
    # @yield [point]
    # @yieldparam point [MetaStruct::Graph::Point]
    # @yieldreturn [Boolean]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def traverse(graph, &iterator)
      return interator.call(graph) if block_given?

      new(graph).traverse
    end
  end

  private_class_method :new

  def initialize(graph)
    @graph = graph
  end

  def traverse
    DFSIterator.new(graph, tree)
  end

  private

  attr_reader :graph
end
