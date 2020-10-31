# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Invariants::Post::HasNoCycles::TraverseTracker
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize
    @tracks = Hash.new { |h, k| h[k] = 0 }
  end

  # @param point [MetaStruct::Graph::Point]
  # @return [Integer]
  #
  # @api private
  # @since 0.1.0
  def track!(point)
    tracks[point] += 1
  end

  # @param block [Block]
  # @yield [point, traverse_count]
  # @yieldparam point [MetaStruct::Graph::Point]
  # @yieldparam traverse_count [Integer]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def each_pair(&block)
    tracks.each_pair(&block)
  end

  private

  # @return [Hash<MetaStruct::Graph::Point,Integer>]
  #
  # @api private
  # @since 0.1.0
  attr_reader :tracks
end
