# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Serializer do
  let(:serializer) { described_class.new(graph) }
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
  let(:point) { MetaStruct::Graph::Point.new(node, []) }
  let(:graph) { MetaStruct::Graph.new(point, [node], [edge]) }

  let(:expected_result) do
    {
      root: {
        uuid: 'super-cool-uuid',
        labels: %w[array of labels],
        properties: {
          'prop_1' => 'cool',
          'prop_2' => 'very'
        }
      },
      nodes: [
        {
          uuid: 'super-cool-uuid',
          labels: %w[array of labels],
          properties: {
            'prop_1' => 'cool',
            'prop_2' => 'very'
          }
        }
      ],
      edges: [
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
      ]
    }
  end

  describe '#call' do
    subject { serializer.call }

    it { is_expected.to eq(expected_result) }
  end

  describe '#to_json' do
    subject { serializer.to_json }

    let(:expected_result) { super().to_json }

    it { is_expected.to eq(expected_result) }
  end
end
