# frozen_string_literal: true

# @api public
# @since 0.1.0
MetaStruct::DIContainer = SmartCore::Container.define do
  namespace(:nodes) do
    register(:serializer) { MetaStruct::Graph::Node::Serializer }
  end

  namespace(:edges) do
    register(:serializer) { MetaStruct::Graph::Edge::Serializer }
  end

  namespace(:graph) do
    register(:serializer) { MetaStruct::Graph::Serializer }
  end
end
