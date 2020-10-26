# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Point::Factory
  class << self
    # @param node [MetaStruct::Graph::Node]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def create(node, edges); end

    # @param node [MetaStruct::Graph::Node]
    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def build(node)
      MetaStruct::Graph::Point.new(node, [])
    end
  end
end
