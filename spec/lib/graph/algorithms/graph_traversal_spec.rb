# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Algorithms::GraphTraversal do
  subject(:iterate) { described_class.traverse(graph, 'uuid-1', &iterator) }

  let(:node_1) { MetaStruct::Graph::Node.create(uuid: 'uuid-1') }
  let(:node_2) { MetaStruct::Graph::Node.create(uuid: 'uuid-2') }
  let(:edge) do
    MetaStruct::Graph::Edge.create(
      left_node: node_1,
      right_node: node_2
    )
  end
  let(:graph) do
    MetaStruct::Graph.create(nodes: [node_1, node_2], edges: [edge])
  end
  let(:iterator) { -> (point, adjacency) { true } }
  let(:points_iterator) { MetaStruct::Graph::Algorithms::PointsIterator }

  before { allow(points_iterator).to receive(:call) }

  it 'calls points iterator with proper args' do
    iterate
    expect(points_iterator).to \
      have_received(:call).with(graph, from_uuid: 'uuid-1', &iterator)
  end
end
