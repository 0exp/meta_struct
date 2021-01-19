# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants::Post::HasNoCycles
  class << self
    # @param graph [MetaStruct::Graph]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def validate!(graph)
      root = graph.root
      cycled_nodes = []
      visited = [root]

      scan(cycled_nodes, visited, root)

      if cycled_nodes.any?
        raise(
          MetaStruct::Graph::GraphCycledEror,
          "You have the following cycled nodes: #{cycled_nodes.map(&:uuid).join(', ')}."
        )
      end
    end

    private

    def scan(cycled_nodes, visited, point)
      point.adjacencies.each do |adjacency|
        left_point = adjacency.left_point
        right_point = adjacency.right_point
        visited = clean_visited_for(left_point, visited)

        if visited.include?(right_point)
          cycled_nodes.push(right_point.node)
          break
        end

        visited.push(right_point)

        scan(cycled_nodes, visited, right_point)
      end
    end

    def clean_visited_for(left_point, visited)
      return visited if visited.last.uuid == left_point.uuid

      [].tap do |visited_till_left_point|
        visited.each do |point|
          visited_till_left_point.push(point)
          break if point.uuid == left_point.uuid
        end
      end
    end
  end
end
