# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Algorithms
  class PointsIterator
    extend Forwardable

    include Enumerable

    # @param graph [MetaStruct::Graph]
    # @param node_uuid [String]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def initialize(graph, uuid = nil)
      @graph = graph
      @uuid = uuid
    end

    def each(&block)
      collection.each(&block)
    end

    # @return [Array<MetaStruct::Graph::Point>]
    #
    # @api private
    # @since 0.1.0
    def collection
      dfs(start_point)
    end

    private

    attr_reader :graph
    attr_reader :uuid

    def_delegators :graph, :root

    def dfs(point)
      flow = [point]
      stack = [point]

      while stack.any?
        current = stack.pop
        adjacencies = sorted_adjacencies(current.adjacencies)

        adjacencies.each do |adjacency|
          right_point = adjacency.right_point

          flow.push(right_point)

          if right_point.adjacencies.any?
            stack.push(right_point)
          else
            stack = []
            break
          end
        end
      end

      flow
    end

    def start_point
      return root unless uuid && !uuid.empty?

      MetaStruct::Graph::Algorithms::FindPoint.call(graph, uuid)
    end

    def sorted_adjacencies(adjacencies = [])
      adjacencies.sort do |left, right|
        right.edge.weight <=> left.edge.weight
      end
    end
  end
end
