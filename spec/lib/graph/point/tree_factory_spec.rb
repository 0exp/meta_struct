# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Point::TreeFactory do
  subject { described_class.create(nodes, edges) }

  let(:root) { MetaStruct::Graph::Node.create }
  let(:child_for_root) { MetaStruct::Graph::Node.create }
  let(:another_child_for_root) { MetaStruct::Graph::Node.create }
  let(:child_for_child_for_root) { MetaStruct::Graph::Node.create }

  let(:edge_for_root) do
    MetaStruct::Graph::Edge.create(
      left_node: root,
      right_node: child_for_root
    )
  end
  let(:another_edge_for_root) do
    MetaStruct::Graph::Edge.create(
      left_node: root,
      right_node: another_child_for_root
    )
  end
  let(:edge_for_child_for_child_for_root) do
    MetaStruct::Graph::Edge.create(
      left_node: child_for_root,
      right_node: child_for_child_for_root
    )
  end

  let(:nodes) { [root, child_for_root, another_child_for_root, child_for_child_for_root] }
  let(:edges) { [edge_for_root, another_edge_for_root, edge_for_child_for_child_for_root] }

  it 'returns point with correct adjacencies' do
    subject
    # binding.pry
  end
end
