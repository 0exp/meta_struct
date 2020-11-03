# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Invariants::Post::HasNoCycles::TraverseTracker
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize
    @tracks = Hash.new do |adjacency_hash, adjacency|
      adjacency_hash[adjacency] = Hash.new do |point_hash, point|
        point_hash[point] = 0
      end
    end
  end

  # @param point [MetaStruct::Graph::Point]
  # @param adjacency [MetaStruct::Graph::Point::Adjacency, nil]
  # @return [Integer]
  #
  # @api private
  # @since 0.1.0
  def track!(point, adjacency)
    tracks[adjacency][point] += 1
  end

  # @param block [Block]
  # @yield [adjacency, point, traverse_count]
  # @yieldparam adjacency [MetaStruct::Graph::Point::Adjacency, nil]
  # @yieldparam point [MetaStruct::Graph::Point]
  # @yieldparam traverse_count [Integer]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def each_pair(&block)
    tracks.each_pair do |adjacency, point_traverse_tracks|
      point_traverse_tracks.each_pair do |point, traverse_count|
        yield(adjacency, point, traverse_count)
      end
    end
  end

  private

  # @return [Hash]
  #
  # @api private
  # @since 0.1.0
  attr_reader :tracks
end
