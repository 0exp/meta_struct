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

    # @api private
    # @since 0.1.0
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

    # @api private
    # @since 0.1.0
    attr_reader :graph

    # @api private
    # @since 0.1.0
    attr_reader :uuid

    # @api private
    # @since 0.1.0
    def_delegators :graph, :root

    # @return [Array<MetaStruct::Graph::Point::Iterator::Entity>]
    #
    # @api private
    # @since 0.1.0
    def dfs(point)
      flow = [build_entity(point)]
      stack = [point]

      while stack.any?
        current = stack.pop
        adjacencies = sorted_adjacencies(current.adjacencies)

        adjacencies.each do |adjacency|
          right_point = adjacency.right_point

          flow.push(build_entity(right_point, adjacency))

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

    # @return [MetaStruct::Graph::Point]
    #
    # @api private
    # @since 0.1.0
    def start_point
      return root unless uuid && !uuid.empty?

      graph.find_point(uuid)
    end

    # @param adjacencies [Array<MetaStruct::Graph::Point::Adjacency>]
    # @return [Array<MetaStruct::Graph::Point::Adjacency>]
    #
    # @api private
    # @since 0.1.0
    def sorted_adjacencies(adjacencies = [])
      adjacencies.sort do |left, right|
        right.weight <=> left.weight
      end
    end

    # @param point [MetaStruct::Graph::Point]
    # @param adjacency [MetaStruct::Graph::Point::Adjacency, nil]
    # @return [MetaStruct::Graph::Point::Iterator::Entity]
    #
    # @api private
    # @since 0.1.0
    def build_entity(point, adjacency = nil)
      if adjacency == nil && point != root
        adjacency = find_adjacency_for(point)
      end

      MetaStruct::Graph::Point::Iterator::Entity.new(point, adjacency)
    end

    # @param point [MetaStruct::Graph::Point]
    # @return [MetaStruct::Graph::Point::Adjacency, nil]
    #
    # @api private
    # @since 0.1.0
    def find_adjacency_for(point)
      MetaStruct::Graph::Algorithms::FindAdjacency.call(graph, point)
    end
  end
end
