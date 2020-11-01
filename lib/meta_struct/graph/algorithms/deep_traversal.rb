# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms::DeepTraversal
  class << self
    # @param graph [MetaStruct::Graph]
    # @param iterator [Block]
    # @yield [point]
    # @yieldparam point [MetaStruct::Graph::Point]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def traverse(graph, &iterator)
      deep_yield(graph.root, &iterator)
    end

    private

    # @param root_point [MetaStruct::Graph::Point]
    # @param iterator [Block]
    # @yield [point]
    # @yieldparam point [MetaStruct::Graph::Point]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def deep_yield(root_point, &iterator)
      yield_root(root_point, &iterator)
      yield_tree(root_point, &iterator)
    end

    # @param root_point [MetaStruct::Graph::Point]
    # @param iterator [Block]
    # @yield [point]
    # @yieldparam point [MetaStruct::Graph::Point]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def yield_root(root_point, &iterator)
      yield(root_point)
    end

    # @param root_point [MetaStruct::Graph::Point]
    # @param iterator [Block]
    # @yield [point]
    # @yieldparam point [MetaStruct::Graph::Point]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def yield_tree(root_point, &iterator)
      root_point.adjacencies.each do |adjacency|
        deep_yield(adjacency.right_point, &iterator)
      end
    end
  end
end
