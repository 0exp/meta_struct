# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Point::TreeFactory do
  subject(:build_tree) { described_class.create(nodes, edges) }

  def adjacencie_right_nodes(point)
    right_points = point.adjacencies.map(&:right_point)

    right_points.map(&:node)
  end

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

  let(:nodes) { [child_for_root, root, another_child_for_root, child_for_child_for_root] }
  let(:edges) { [edge_for_root, another_edge_for_root, edge_for_child_for_child_for_root] }

  it 'returns point with correct adjacencies' do
    aggregate_failures "point's adjacencies" do
      expect(build_tree.node).to eq(root) 
      expect(adjacencie_right_nodes(build_tree)).to match_array([child_for_root, another_child_for_root])

      child_right_nodes = build_tree.adjacencies.map do |adjacency|
        adjacencie_right_nodes(adjacency.right_point)
      end
      expect(child_right_nodes).to match_array([[child_for_child_for_root], []])
    end
  end
end
