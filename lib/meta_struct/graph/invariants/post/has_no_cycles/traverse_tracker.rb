# frozen_string_literal: true

# @api private
# @since 0.1.0
class MetaStruct::Graph::Invariants::Post::HasNoCycles::TraverseTracker

  class Path
    def initialize(initial_point)
      @initial_point = initial_point
      @adjacencies = []
    end

    def <<(adjacency)
      @adjacencies << adjacency
    end
  end

  attr_reader :pathes
  attr_reader :current_path

  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize
    @tracks = Hash.new do |point_hash, point|
      point_hash[point] = Hash.new do |adjacency_hash, adjacency|
        adjacency_hash[adjacency] = 0
      end
    end

    @pathes = {}
    @current_path = nil
  end

  # @param point [MetaStruct::Graph::Point]
  # @param adjacency [MetaStruct::Graph::Point::Adjacency, nil]
  # @return [Integer]
  #
  # @api private
  # @since 0.1.0
  def track!(point, adjacency)
    tracks[adjacency][point] += 1
    if @pathes.empty?
      path = Path.new(point.uuid)
      path << "#{adjacency&.left_point&.uuid}->#{adjacency&.right_point&.uuid}"
      @current_path = path
      @pathes[point.uuid] ||= []
      @pathes[point.uuid] << path
    else
      unless @pathes.key?(adjacency.left_point.uuid)
        path = Path.new(adjacency.left_point.uuid)
        path << "#{adjacency&.left_point&.uuid}->#{adjacency&.right_point&.uuid}"
        @current_path = path
        @pathes[adjacency.left_point.uuid] ||= []
        @pathes[adjacency.left_point.uuid] << path
      else
        @current_path << "#{adjacency&.left_point&.uuid}->#{adjacency&.right_point&.uuid}"
      end
    end
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
