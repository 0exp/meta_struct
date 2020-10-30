# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Node::Serializer do
  let(:serializer) { described_class.new(node) }
  let(:node) do
    MetaStruct::Graph::Node.create(
      uuid: 'super-cool-uuid',
      labels: %w[array of labels],
      properties: {
        prop_1: 'cool',
        prop_2: 'very'
      }
    )
  end

  describe '#call' do
    subject { serializer.call }

    let(:expected_result) do
      {
        uuid: 'super-cool-uuid',
        labels: %w[array of labels],
        properties: {
          'prop_1' => 'cool',
          'prop_2' => 'very'
        }
      }
    end

    it { is_expected.to eq(expected_result) }
  end

  describe '#to_json' do
    subject { serializer.to_json }

    let(:expected_result) do
      {
        uuid: 'super-cool-uuid',
        labels: %w[array of labels],
        properties: {
          'prop_1' => 'cool',
          'prop_2' => 'very'
        }
      }.to_json
    end

    it { is_expected.to eq(expected_result) }
  end
end
