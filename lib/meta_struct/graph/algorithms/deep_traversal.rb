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
    # @param adjacency [MetaStruct::Graph::Adjacency, nil]
    # @param iterator [Block]
    # @yield [point]
    # @yieldparam point [MetaStruct::Graph::Point]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def deep_yield(root_point, adjacency = nil, &iterator)
      yield_root(root_point, adjacency, &iterator)
      yield_tree(root_point, &iterator)
    end

    # @param root_point [MetaStruct::Graph::Point]
    # @param adjacency [MetaStruct::Graph::Adjacency, nil]
    # @param iterator [Block]
    # @yield [point, adjacency]
    # @yieldparam point [MetaStruct::Graph::Point]
    # @yieldparam adjacency [MetaStruct::Graph::Adjacency, nil]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def yield_root(root_point, adjacency = nil, &iterator)
      yield(root_point, adjacency)
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
        deep_yield(adjacency.right_point, adjacency, &iterator)
      end
    end
  end
end
