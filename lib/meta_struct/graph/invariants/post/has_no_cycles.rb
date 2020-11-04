# frozen_string_literal: true

module MetaStruct::Graph::Invariants::Post
  # @api private
  # @since 0.1.0
  module HasNoCycles
    require_relative 'has_no_cycles/traverse_tracker'

    # @return [Integer]
    #
    # @api private
    # @since 0.1.0
    CYCLE_FACTOR = 2

    class << self
      # @param graph [MetaStruct::Graph]
      # @return [void]
      #
      # @api private
      # @since 0.1.0
      def validate!(graph)
        tracker = HasNoCycles::TraverseTracker.new

        graph.deep_traverse do |point, adjacency|
          puts "(#{point.uuid}): #{adjacency&.left_point&.uuid}->#{adjacency&.right_point&.uuid}"
          tracker.track!(point, adjacency)
          # check_for_cycles!(graph, tracker)
        end

        binding.pry
      end

      private

      # Cycle factors:
      #   1. Has adjacencies (to another points);
      #   2. Traversed more than one time.
      #
      # @param graph [MetaStruct::Graph]
      # @param tracker [MetaStruct::Graph::Invariants::Post::HasNoCycles::TraverseTracker]
      # @return [void]
      #
      # @api private
      # @since 0.1.0
      def check_for_cycles!(graph, tracker)
        tracker.each_pair do |tracked_adjacency, tracked_point, traverse_count|
          next unless traverse_count >= CYCLE_FACTOR
          cycled_node = tracked_adjacency.left_point
          raise(MetaStruct::Graph::GraphHasCyclesInvariantError.new(
            "Your graph has a cycle on a node with UUID: '#{cycled_node.uuid}'",
            graph: graph,
            cycled_adjacencies: [tracked_adjacency],
            cycled_points: [cycled_node]
          ))
        end
      end
    end
  end
end
