# frozen_string_literal: true

RSpec.describe MetaStruct::Graph do
  let!(:node_1) { MetaStruct::Graph::Node.create(uuid: 'n1') }
  let!(:node_2) { MetaStruct::Graph::Node.create(uuid: 'n2') }
  let!(:node_3) { MetaStruct::Graph::Node.create(uuid: 'n3') }

  let!(:edge_1) { MetaStruct::Graph::Edge.create(left_node: node_1, right_node: node_2) }
  let!(:edge_2) { MetaStruct::Graph::Edge.create(left_node: node_2, right_node: node_3) }

  describe 'creation' do
    describe 'attribute incompatability' do
      let!(:node_list) { [node_1, node_2, node_3] }
      let!(:edge_list) { [edge_1, edge_2] }

      specify 'fails on invalid node and edge lists' do
        aggregate_failures 'invalid lists' do
          expect do # empty nodes
            MetaStruct::Graph.create(nodes: [], edges: edge_list)
          end.to raise_error(MetaStruct::Graph::EmptyNodeListError)

          expect do # empty edgees
            MetaStruct::Graph.create(nodes: node_list, edges: [])
          end.to raise_error(MetaStruct::Graph::EmptyEdgeListError)

          expect do # no any lists are provided
            MetaStruct::Graph.create
          end.to raise_error(MetaStruct::Graph::EmptyNodeListError)

          expect do # no any lists are provided
            MetaStruct::Graph.create(nodes: [], edges: [])
          end.to raise_error(MetaStruct::Graph::EmptyNodeListError)

          expect do # invalid type of node list
            MetaStruct::Graph.create(nodes: Object.new, edges: edge_list)
          end.to raise_error(MetaStruct::Graph::InvalidNodeListError)

          expect do # invalid type of edge list
            MetaStruct::Graph.create(nodes: node_list, edges: Object.new)
          end.to raise_error(MetaStruct::Graph::InvalidEdgeListError)

          expect do # non-node objects in node list
            MetaStruct::Graph.create(nodes: [Object.new], edges: edge_list)
          end.to raise_error(MetaStruct::Graph::InvalidNodeListError)

          expect do # non-edge objects in edge list
            MetaStruct::Graph.create(nodes: node_list, edges: [Object.new])
          end.to raise_error(MetaStruct::Graph::InvalidEdgeListError)
        end
      end

      specify 'fails on node dupilicates and edge duplicates' do
        aggregate_failures 'duplicates in node and edge lists' do
          expect do # duplicates in node list
            original_node  = MetaStruct::Graph::Node.create(uuid: 'duplicate')
            node_duplicate = MetaStruct::Graph::Node.create(uuid: 'duplicate')

            edge = MetaStruct::Graph::Edge.create(
              left_node: original_node,
              right_node: node_duplicate
            )

            MetaStruct::Graph.create(nodes: [original_node, node_duplicate], edges: [edge])
          end.to raise_error(MetaStruct::Graph::NodeListDuplicateError)

          expect do # duplicates in edge list
            left_node = MetaStruct::Graph::Node.create(uuid: 'test_1')
            right_node = MetaStruct::Graph::Node.create(uuid: 'test_2')

            original_edge = MetaStruct::Graph::Edge.create(
              left_node: left_node,
              right_node: right_node,
              weight: 1 # weight should be ignored!
            )
            edge_duplicate = MetaStruct::Graph::Edge.create(
              left_node: left_node,
              right_node: right_node,
              weight: 2 # weight should be ignored!
            )

            MetaStruct::Graph.create(
              nodes: [left_node, right_node],
              edges: [original_edge, edge_duplicate]
            )
          end.to raise_error(MetaStruct::Graph::EdgeListDuplicateError)
        end
      end
    end

    describe 'invariants' do
      specify 'has no non-connected nodes' do
        expect do # has inconsistent invariant
          MetaStruct::Graph.create(
            nodes: [
              node_1,
              node_2,
              node_3 # non-connected node (inconsistent invariant)
            ],
            edges: [
              edge_1 # connects node_1 and node_2 only
            ]
          )
        end.to raise_error(MetaStruct::Graph::NonConnectedNodeError)

        expect do # has no incosistent invariant
          MetaStruct::Graph::Create(
            node: [node_1, node_2, node_3],
            edges: [edge_1, edge_2]
          )
        end.not_to raise_error(MetaStruct::Graph::NonConnectedNodeError)
      end

      pending 'has only one root'
      pending 'has at least one exit'
      pending 'has no cycles'
    end
  end
end
