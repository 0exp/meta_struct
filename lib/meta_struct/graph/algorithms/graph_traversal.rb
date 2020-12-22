# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms::GraphTraversal
  class << self
    # @param graph [MetaStruct::Graph]
    # @param iterator [Block]
    # @param uuid [String, nil]
    # @return [void]
    #
    # @api public
    # @since 0.1.0
    def traverse(graph, uuid = nil, &iterator)
      MetaStruct::Graph::Algorithms::PointsIterator
        .call(graph, from_uuid: uuid, &iterator)
    end
  end
end
