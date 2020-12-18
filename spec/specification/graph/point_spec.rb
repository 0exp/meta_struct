# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Point do
  let(:node) do
    MetaStruct::Graph::Node.create(labels: labels, properties: properties)
  end
  let(:adjacencies) { [] }
  let(:labels) { %w[cool labels] }
  let(:properties) { { cool: 'property' } }
  let(:point) { MetaStruct::Graph::Point.new(node, adjacencies) }

  describe '#uuid' do
    subject { point.uuid }

    it { is_expected.to eq(node.uuid) }
  end

  describe '#labels' do
    subject { point.labels }

    it { is_expected.to match_array(%w[cool labels]) }
  end

  describe '#properties' do
    subject { point.properties }

    it { is_expected.to eq({ 'cool' => 'property' }) }
  end
end
