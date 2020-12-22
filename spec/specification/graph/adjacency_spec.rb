# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Point::Adjacency do
  let(:left_node) { MetaStruct::Graph::Node.create }
  let(:right_node) { MetaStruct::Graph::Node.create }
  let(:left_point) { MetaStruct::Graph::Point.new(left_node, []) }
  let(:right_point) { MetaStruct::Graph::Point.new(right_node, []) }
  let(:edge) do
    MetaStruct::Graph::Edge.create(
      left_node: left_node,
      right_node: right_node,
      weight: 1,
      labels: %w[edge labels],
      properties: { 'edge' => 'property' }
    )
  end
  let(:adjacency) do
    MetaStruct::Graph::Point::Adjacency.new(left_point, right_point, edge)
  end

  describe '#weight' do
    subject { adjacency.weight }

    it { is_expected.to eq 1 }
  end

  describe '#left_node' do
    subject { adjacency.left_node }

    it { is_expected.to eq(left_node) }
  end

  describe '#right_node' do
    subject { adjacency.right_node }

    it { is_expected.to eq(right_node) }
  end

  describe '#edge_labels' do
    subject { adjacency.edge_labels }

    it { is_expected.to eq(%w[edge labels]) }
  end

  describe '#edge_properties' do
    subject { adjacency.edge_properties }

    it { is_expected.to eq({ 'edge' => 'property' }) }
  end

  describe '#end?' do
    subject { adjacency.end? }

    it { is_expected.to be_falsey }

    context 'when right point is nil' do
      let(:right_point) { nil }

      it { is_expected.to be_truthy }
    end
  end
end
