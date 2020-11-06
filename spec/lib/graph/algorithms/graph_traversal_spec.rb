# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Algorithms::GraphTraversal do
  let(:node_1) { MetaStruct::Graph::Node.create(uuid: 'uuid-1') }
  let(:node_2) { MetaStruct::Graph::Node.create(uuid: 'uuid-2') }
  let(:node_3) { MetaStruct::Graph::Node.create(uuid: 'uuid-3') }

  let(:adjacency_1) do
    MetaStruct::Graph::Point::Adjacency.new(point_1, point_2, nil)
  end
  let(:adjacency_2) do
    MetaStruct::Graph::Point::Adjacency.new(point_2, point_3, nil)
  end

  let(:point_1) { MetaStruct::Graph::Point.new(node_1, []) }
  let(:point_2) { MetaStruct::Graph::Point.new(node_2, []) }
  let(:point_3) { MetaStruct::Graph::Point.new(node_3, []) }

  let(:entity_1) { MetaStruct::Graph::Point::Iterator::Entity.new(point_1) }
  let(:entity_2) { MetaStruct::Graph::Point::Iterator::Entity.new(point_2, adjacency_1) }
  let(:entity_3) { MetaStruct::Graph::Point::Iterator::Entity.new(point_3, adjacency_2) }

  let(:entities) { [entity_1, entity_2, entity_3] }

  before do
    point_1.adjacencies = [adjacency_1]
    point_2.adjacencies = [adjacency_2]

    allow(described_class).to receive(:points_iterator).with(nil, nil).and_return(entities)
  end

  it 'breakes in exact place' do
    iterated_points = []
    iterated_adjacencies = []

    described_class.traverse(nil) do |point, adjacency|
      iterated_points.push(point)
      iterated_adjacencies.push(adjacency)

      point.node.uuid != 'uuid-2'
    end

    expect(iterated_points).to match_array([point_1, point_2])
    expect(iterated_adjacencies).to match_array([nil, adjacency_1])
  end
end
