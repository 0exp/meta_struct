# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Invariants::Pre::HasOnlyOneRoot do
  subject { -> { described_class.validate!(nodes, edges) } }

  let(:nodes) { [] }
  let(:edges) { [] }

  it { is_expected.to \
    raise_error(
      MetaStruct::Graph::RootNotFoundInvariantError, 
      'Your graph has no root node.'
    ) 
  }

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

    let(:expected_message) do
      "Your graph has more than one root (you can have only one root in graph entity). " + 
      "Root node UUIDs: #{[root_1, root_2].map(&:uuid).join(', ')}."
    end

    it { is_expected.to \
      raise_error(
        MetaStruct::Graph::MoreThanOneRootInvariantError, 
        expected_message
      ) 
    }
  end
end
