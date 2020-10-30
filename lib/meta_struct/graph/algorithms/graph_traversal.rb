# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms::GraphTraversal
  class << self
    # @param graph [MetaStruct::Graph]
    # @param iterator [Block]
    # @yield [point]
    # @yieldparam point [MetaStruct::Graph::Point]
    # @yieldreturn [Boolean]
    # @return [void]
    #
    # @api public
    # @since 0.1.0
    def traverse(graph, uuid = nil, &iterator)
      points_iterator(graph, uuid).each do |point|
        break unless iterator.yield(point)
      end
    end

    private

    # @api private
    # @since 0.1.0
    def points_iterator(graph, uuid)
      MetaStruct::Graph::Algorithms::PointsIterator.new(graph, uuid)
    end
  end
end
