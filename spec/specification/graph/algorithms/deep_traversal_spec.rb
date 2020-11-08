# frozen_string_literal: true

RSpec.describe MetaStruct::Graph do
  let!(:node_1) { MetaStruct::Graph::Node.create(uuid: 'n1') }
  let!(:node_2) { MetaStruct::Graph::Node.create(uuid: 'n2') }
  let!(:node_3) { MetaStruct::Graph::Node.create(uuid: 'n3') }
  let!(:node_4) { MetaStruct::Graph::Node.create(uuid: 'n4') }
  let!(:node_5) { MetaStruct::Graph::Node.create(uuid: 'n5') }
  let!(:node_6) { MetaStruct::Graph::Node.create(uuid: 'n6') }
  let!(:node_7) { MetaStruct::Graph::Node.create(uuid: 'n7') }
  let!(:node_8) { MetaStruct::Graph::Node.create(uuid: 'n8') }

  let!(:edge_1) { MetaStruct::Graph::Edge.create(left_node: node_1, right_node: node_2, weight: 0) }
  let!(:edge_2) { MetaStruct::Graph::Edge.create(left_node: node_2, right_node: node_3, weight: 0) }
  let!(:edge_3) { MetaStruct::Graph::Edge.create(left_node: node_2, right_node: node_4, weight: 1) }
  let!(:edge_4) { MetaStruct::Graph::Edge.create(left_node: node_4, right_node: node_5, weight: 0) }
  let!(:edge_5) { MetaStruct::Graph::Edge.create(left_node: node_3, right_node: node_5, weight: 0) }
  let!(:edge_6) { MetaStruct::Graph::Edge.create(left_node: node_5, right_node: node_6, weight: 0) }
  let!(:edge_7) { MetaStruct::Graph::Edge.create(left_node: node_6, right_node: node_7, weight: 0) }
  let!(:edge_8) { MetaStruct::Graph::Edge.create(left_node: node_6, right_node: node_8, weight: 1) }
  let!(:edge_9) { MetaStruct::Graph::Edge.create(left_node: node_8, right_node: node_2, weight: 0) }

  let!(:graph) do
    MetaStruct::Graph.create(
      nodes: [node_1, node_2, node_3, node_4, node_5, node_6, node_7, node_8],
      edges: [edge_1, edge_2, edge_3, edge_4, edge_5, edge_6, edge_7, edge_8],
    )
  end

  describe 'algoritms: deep traversal' do
    specify 'iterates all points with appropriated adjacencies' do
    end
    # просто проверить что мы пробегаем ВСЕ ноды (плюс похоже надо в траверс добавить ADJACENCY (помимо поинта), по которой прошли на сооветствтующий поинт)
  end
end
