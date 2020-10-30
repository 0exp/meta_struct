# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Edge::Serializer do
  let(:serializer) { described_class.new(edge) }
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
  let(:edge) do
    MetaStruct::Graph::Edge.create(
      left_node: node,
      right_node: node,
      labels: %w[array of labels],
      properties: {
        prop_1: 'cool',
        prop_2: 'very'
      },
      weight: 2
    )
  end

  describe '#call' do
    subject { serializer.call }

    let(:expected_result) do
      {
        left_node: {
          uuid: 'super-cool-uuid',
          labels: %w[array of labels],
          properties: {
            'prop_1' => 'cool',
            'prop_2' => 'very'
          }
        },
        right_node: {
          uuid: 'super-cool-uuid',
          labels: %w[array of labels],
          properties: {
            'prop_1' => 'cool',
            'prop_2' => 'very'
          }
        },
        labels: %w[array of labels],
        properties: {
          'prop_1' => 'cool',
          'prop_2' => 'very'
        },
        weight: 2
      }
    end

    it { is_expected.to eq(expected_result) }
  end

  describe '#to_json' do
    subject { serializer.to_json }

    let(:expected_result) do
      {
        left_node: {
          uuid: 'super-cool-uuid',
          labels: %w[array of labels],
          properties: {
            'prop_1' => 'cool',
            'prop_2' => 'very'
          }
        },
        right_node: {
          uuid: 'super-cool-uuid',
          labels: %w[array of labels],
          properties: {
            'prop_1' => 'cool',
            'prop_2' => 'very'
          }
        },
        labels: %w[array of labels],
        properties: {
          'prop_1' => 'cool',
          'prop_2' => 'very'
        },
        weight: 2
      }.to_json
    end

    it { is_expected.to eq(expected_result) }
  end
end
