# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Invariants::Pre::HasAtLeastOneExit do
  subject { -> { described_class.validate!(nodes, edges) } }

  let(:nodes) { [] }
  let(:edges) { [] }

  it {
    expect(subject).to \
      raise_error(
        MetaStruct::Graph::NoExitNodeInvariantError,
        'Your graph has no exit nodes (you should provide at least one exit node).'
      )
  }

  context 'when root and bound the same' do
    let(:root) { MetaStruct::Graph::Node.create }
    let(:child_edge_for_root_) do
      MetaStruct::Graph::Edge.create(
        left_node: root,
        right_node: root
      )
    end

    it {
      expect(subject).to \
        raise_error(
          MetaStruct::Graph::NoExitNodeInvariantError,
          'Your graph has no exit nodes (you should provide at least one exit node).'
        )
    }
  end

  context 'when several roots' do
    let(:root_1) { MetaStruct::Graph::Node.create }
    let(:root_2) { MetaStruct::Graph::Node.create }
    let(:child_for_root_1) { MetaStruct::Graph::Node.create }
    let(:another_child_for_root_1) { MetaStruct::Graph::Node.create }
    let(:child_for_root_2) { MetaStruct::Graph::Node.create }

    let(:child_edge_for_root_1) do
      MetaStruct::Graph::Edge.create(
        left_node: root_1,
        right_node: child_for_root_1
      )
    end
    let(:another_child_edge_for_root_1) do
      MetaStruct::Graph::Edge.create(
        left_node: root_1,
        right_node: another_child_for_root_1
      )
    end
    let(:child_edge_for_root_2) do
      MetaStruct::Graph::Edge.create(
        left_node: root_2,
        right_node: child_for_root_2
      )
    end

    let(:nodes) do
      [root_1, root_2, child_for_root_1, another_child_for_root_1, child_for_root_2]
    end
    let(:edges) do
      [child_edge_for_root_1, another_child_edge_for_root_1, child_edge_for_root_2]
    end

    it { is_expected.not_to raise_error(MetaStruct::Graph::NoExitNodeInvariantError) }
  end
end
