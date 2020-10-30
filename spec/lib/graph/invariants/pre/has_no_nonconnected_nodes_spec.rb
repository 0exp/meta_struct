# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Invariants::Pre::HasNoNonconnectedNodes do
  subject { -> { described_class.validate!(nodes, edges) } }

  let(:nodes) { [] }
  let(:edges) { [] }

  it { is_expected.not_to raise_error(MetaStruct::Graph::NonConnectedNodeInvariantError) }

  context 'when nodes provided' do
    let(:root_1) { MetaStruct::Graph::Node.create }
    let(:root_2) { MetaStruct::Graph::Node.create }

    let(:nodes) { [root_1, root_2] }

    let(:expected_message) do
      "Some nodes has no edges (all nodes should have edges). " \
        "Non-connected node UUIDs: #{nodes.map(&:uuid).join(', ')}."
    end

    it {
      expect(subject).to \
        raise_error(
          MetaStruct::Graph::NonConnectedNodeInvariantError,
          expected_message
        )
    }
  end
end
