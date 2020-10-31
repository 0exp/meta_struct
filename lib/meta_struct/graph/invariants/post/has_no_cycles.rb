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

        graph.deep_traverse do |point|
          tracker.track!(point)
          check_for_cycles!(graph, point, tracker)
        end
      end

      private

      # @param graph [MetaStruct::Graph]
      # @param point [MetaStruct::Graph::Point]
      # @param tracker [MetaStruct::Graph::Invariants::Post::HasNoCycles::TraverseTracker]
      # @return [void]
      #
      # @api private
      # @since 0.1.0
      def check_for_cycles!(graph, point, tracker)
        tracker.each_pair do |point, traverse_count|
          raise(MetaStruct::Graph::GraphHasCyclesInvariantError.new(
            "Your graph has a cycle on a node with UUID '#{point.uuid}'",
            graph: graph, cycled_points: [point]
          )) unless traverse_count < CYCLE_FACTOR
        end
      end
    end
  end
end
