# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Algorithms::FindAdjacency do
  subject { service }

  let(:root) { MetaStruct::Graph::Node.create }
  let(:child_for_root) { MetaStruct::Graph::Node.create }
  let(:another_child_for_root) { MetaStruct::Graph::Node.create }
  let(:child_for_child_for_root) { MetaStruct::Graph::Node.create }

  let(:edge_for_root) do
    MetaStruct::Graph::Edge.create(
      left_node: root,
      right_node: child_for_root
    )
  end
  let(:another_edge_for_root) do
    MetaStruct::Graph::Edge.create(
      left_node: root,
      right_node: another_child_for_root
    )
  end
  let(:edge_for_child_for_child_for_root) do
    MetaStruct::Graph::Edge.create(
      left_node: child_for_root,
      right_node: child_for_child_for_root
    )
  end

  let(:nodes) { [child_for_root, root, another_child_for_root, child_for_child_for_root] }
  let(:edges) { [edge_for_root, another_edge_for_root, edge_for_child_for_child_for_root] }

  let(:tree) { MetaStruct::Graph::Point::TreeFactory.create(nodes, edges) }
  let(:graph) { MetaStruct::Graph.new(tree, nodes, edges) }

  let(:point) { tree }

  let(:service) { described_class.call(graph, point) }

  it { is_expected.to be_nil }

  context 'when looking for existing adjacency' do
    subject { service.right_point.node }

    let(:point) do
      MetaStruct::Graph::Algorithms::FindPoint.call(graph, another_child_for_root.uuid)
    end

    it { is_expected.to eq(another_child_for_root) }
  end
end