# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Algorithms::GraphTraversal do
  let(:node_1) { MetaStruct::Graph::Node.create(uuid: 'uuid-1') }
  let(:node_2) { MetaStruct::Graph::Node.create(uuid: 'uuid-2') }
  let(:node_3) { MetaStruct::Graph::Node.create(uuid: 'uuid-3') }

  let(:point_1) { MetaStruct::Graph::Point.new(node_1, []) }
  let(:point_2) { MetaStruct::Graph::Point.new(node_2, []) }
  let(:point_3) { MetaStruct::Graph::Point.new(node_3, []) }
  
  let(:points) { [point_1, point_2, point_3] }

  before do
    allow(described_class).to receive(:points_iterator).with(nil, nil).and_return(points)
  end

  it 'breakes in exact place' do
    iterated_points = []

    described_class.traverse(nil) do |point|
      iterated_points.push(point)
      
      point.node.uuid != 'uuid-2'
    end

    expect(iterated_points).to match_array([point_1, point_2])
  end
end
