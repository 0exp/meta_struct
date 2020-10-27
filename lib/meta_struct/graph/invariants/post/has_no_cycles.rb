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

      scan(cycled_nodes, visited, root, true)
      
      if cycled_nodes.any?
        raise(
          MetaStruct::Graph::GraphCycledEror,
          "You have the following cycled nodes: #{cycled_nodes.map(&:uuid).join(', ')}."
        )
      end
    end

    private

    def scan(cycled_nodes, visited, point, reset_visited = false)
      point.adjacencies.each do |adjacency|
        right_point = adjacency.right_point
        
        if visited.include?(right_point)
          cycled_nodes.push(right_point.node)
          break
        end

        visited.push(right_point)

        scan(cycled_nodes, visited, right_point)
        visited = [point] if reset_visited
      end
    end
  end
end
