# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Algorithms::FindRoot
  class << self
    # @param graph [MetaStruct::Graph]
    # @return [MetaStruct::Graph::Point, nil]
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
