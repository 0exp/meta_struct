# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants::HasOnlyOneRoot
  class << self
    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def validate!(nodes, edges)
      # есть рут: есть строго одна нода, НА которую не ведет ни одна другая
    end
  end
end
