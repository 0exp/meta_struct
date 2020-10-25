# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants::HasNoNonconnectedNodes
  class << self
    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def validate!(nodes, edges); end
  end
end
