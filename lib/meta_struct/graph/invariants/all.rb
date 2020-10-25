# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants
  module All
    class << self
      # @param nodes [Array<MetaStruct::Graph::Node>]
      # @param edges [Array<MetaStruct::Graph::Edge>]
      # @return [void]
      #
      # @api private
      # @since 0.1.0
      def validate!(nodes, edges)
        HasNoNonconnectedNodes.validate!(nodes, edges)
        HasOneRoot.validate!(nodes, edges)
        HasNoCycles.validate!(nodes, edges)
      end
    end
  end
end
