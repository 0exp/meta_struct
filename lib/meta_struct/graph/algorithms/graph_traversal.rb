# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms::GraphTraversal
  class << self
    # @since 0.1.0
    include SmartCore::Injection(::MetaStruct::DIContainer)

    # @since 0.1.0
    import(
      { points_iterator: 'graph.algorithms.points_iterator' },
      bind: :dynamic,
      access: :private
    )

    # @param graph [MetaStruct::Graph]
    # @param iterator [Block]
    # @param uuid [String, nil]
    # @return [void]
    #
    # @api public
    # @since 0.1.0
    def traverse(graph, uuid = nil, &iterator)
      points_iterator.call(graph, from_uuid: uuid, &iterator)
    end
  end
end
