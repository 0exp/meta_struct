# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms::DirectedTraversal
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
    def traverse(graph, &iterator); end
  end
end
