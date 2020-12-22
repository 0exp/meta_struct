# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Algorithms::PointsIterator do
  let(:root) { MetaStruct::Graph::Node.create(labels: ['root']) }
  let(:child_for_root) { MetaStruct::Graph::Node.create(labels: ['first level weight 1']) }
  let(:another_child_for_root) { MetaStruct::Graph::Node.create(labels: ['first level weight 2']) }
  let(:child_for_child_for_root) do
    MetaStruct::Graph::Node.create(labels: ['second level weight -1'])
  end

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

  let(:graph) { MetaStruct::Graph.create(nodes: nodes, edges: edges) }

  let(:node_uuid) { '' }
  let(:flow) { [] }
  let(:iterator) do
    lambda do |point, adjacency|
      flow << { uuid: point.uuid, edge: adjacency&.edge }
      true
    end
  end

  describe '.call' do
    subject do
      described_class.call(graph, from_uuid: node_uuid) do |point, adjacency|
        iterator.call(point, adjacency)
      end

      flow
    end

    context 'following regarding weight sorting' do
      let(:expected_result) do
        [
          { uuid: root.uuid, edge: nil },
          { uuid: another_child_for_root.uuid, edge: another_edge_for_root }
        ]
      end

      it { is_expected.to match(expected_result) }

      context 'when iterator for specific point has not been succeed' do
        let(:iterator) do
          lambda do |point, adjacency|
            flow << { uuid: point.uuid, edge: adjacency&.edge }
            point.uuid != another_child_for_root.uuid
          end
        end
        let(:expected_result) do
          [
            { uuid: root.uuid, edge: nil },
            { uuid: another_child_for_root.uuid, edge: another_edge_for_root },
            { uuid: child_for_root.uuid, edge: edge_for_root },
            {
              uuid: child_for_child_for_root.uuid,
              edge: edge_for_child_for_child_for_root
            }
          ]
        end

        it { is_expected.to match(expected_result) }
      end
    end

    context 'when starting from specific node' do
      let(:node_uuid) { child_for_root.uuid }
      let(:expected_result) do
        [
          { uuid: child_for_root.uuid, edge: edge_for_root },
          {
            uuid: child_for_child_for_root.uuid,
            edge: edge_for_child_for_child_for_root
          }
        ]
      end

      it { is_expected.to match(expected_result) }
    end
  end
end
