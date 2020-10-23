# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Algorithms::FindBoundNodes
  class << self
    # @return [Array<MetaStruct::Graph::Point>]
    #
    # @api private
    # @since 0.1.0
    def call(graph)
      new(graph).find
    end
  end

  private_class_method :new

  def initialize(graph)
    @graph = graph
  end

  def find
  end

  private

  attr_reader :graph
end
