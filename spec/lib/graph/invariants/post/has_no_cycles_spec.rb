# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Invariants::Post::HasNoCycles do
  subject { -> { described_class.validate!(graph) } }

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

  it { is_expected.not_to raise_error }

  context 'when graph has cycles' do
    let(:cycled_edge_1) do
      MetaStruct::Graph::Edge.create(
        left_node: child_for_child_for_root,
        right_node: child_for_child_for_root
      )
    end
    let(:cycled_edge_2) do
      MetaStruct::Graph::Edge.create(
        left_node: another_child_for_root,
        right_node: another_child_for_root
      )
    end

    let(:edges) { super() + [cycled_edge_1, cycled_edge_2] }

    let(:expected_message) do
      cycled_nodes = [child_for_child_for_root, another_child_for_root]
      "You have the following cycled nodes: #{cycled_nodes.map(&:uuid).join(', ')}."
    end

    it { is_expected.to raise_error(MetaStruct::Graph::GraphCycledEror, expected_message) }
  end

  context 'when graph has long cycle' do
    let(:cycled_edge) do
      MetaStruct::Graph::Edge.create(
        left_node: child_for_child_for_root,
        right_node: child_for_root
      )
    end

    let(:edges) { super().push(cycled_edge) }

    let(:expected_message) do
      cycled_nodes = [child_for_root]
      "You have the following cycled nodes: #{cycled_nodes.map(&:uuid).join(', ')}."
    end

    it { is_expected.to raise_error(MetaStruct::Graph::GraphCycledEror, expected_message) }
  end
end
