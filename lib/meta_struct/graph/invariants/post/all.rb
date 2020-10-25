# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants::Post
  module All
    class << self
      # @param graph [MetaStruct::Graph]
      # @return [void]
      #
      # @api private
      # @since 0.1.0
      def validate!(graph)
        self.then do
          HasNoCycles.validate!(graph)
        end
      end
    end
  end
end
