# frozen_string_literal: true

# @api public
# @since 0.1.0
MetaStruct::DIContainer = SmartCore::Container.define do
  namespace(:graph) do
    register(:serializer) { MetaStruct::Graph::Serializer }

    namespace(:nodes) do
      register(:serializer) { MetaStruct::Graph::Node::Serializer }
    end

    namespace(:edges) do
      register(:serializer) { MetaStruct::Graph::Edge::Serializer }
    end

    namespace(:algorithms) do
      register(:points_iterator) { MetaStruct::Graph::Algorithms::PointsIterator }
      register(:find_adjacency) { MetaStruct::Graph::Algorithms::FindAdjacency }
      register(:find_root_nodes) { MetaStruct::Graph::Algorithms::FindRootNodes }
      register(:find_point) { MetaStruct::Graph::Algorithms::FindPoint }
      register(:graph_traversal) { MetaStruct::Graph::Algorithms::GraphTraversal }
    end
  end
end
