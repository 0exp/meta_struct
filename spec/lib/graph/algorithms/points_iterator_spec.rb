# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Algorithms::PointsIterator do
  let(:iterator) { described_class.new(graph, node_uuid) }

  let(:root) { MetaStruct::Graph::Node.create(labels: ['root']) }
  let(:child_for_root) { MetaStruct::Graph::Node.create(labels: ['first level weight 1']) }
  let(:another_child_for_root) { MetaStruct::Graph::Node.create(labels: ['first level weight 2']) }
  let(:child_for_child_for_root) { MetaStruct::Graph::Node.create(labels: ['second level weight -1']) }

  let(:edge_for_root) do
    MetaStruct::Graph::Edge.create(
      left_node: root,
      right_node: child_for_root,
      weight: 1
    )
  end
  let(:another_edge_for_root) do
    MetaStruct::Graph::Edge.create(
      left_node: root,
      right_node: another_child_for_root,
      weight: 2
    )
  end
  let(:edge_for_child_for_child_for_root) do
    MetaStruct::Graph::Edge.create(
      left_node: child_for_root,
      right_node: child_for_child_for_root,
      weight: -1
    )
  end

  let(:nodes) { [child_for_root, root, another_child_for_root, child_for_child_for_root] }
  let(:edges) { [edge_for_root, another_edge_for_root, edge_for_child_for_child_for_root] }

  let(:tree) { MetaStruct::Graph::Point::TreeFactory.create(nodes, edges) }
  let(:graph) { MetaStruct::Graph.new(tree, nodes, edges) }

  let(:node_uuid) { '' }

  specify { expect(iterator).to respond_to(:each) }

  describe '#collection' do
    subject { iterator.collection.map(&:node) }

    let(:expected_result) { [root, another_child_for_root] }

    it { is_expected.to match_array(expected_result) }

    context 'when starting from specific node' do
      let(:node_uuid) { child_for_root.uuid }
      let(:expected_result) { [child_for_root, child_for_child_for_root] }

      it { is_expected.to match_array(expected_result) }
    end
  end
end
