# frozen_string_literal: true

RSpec.describe MetaStruct::Graph do
  let!(:node_1) { MetaStruct::Graph::Node.create(uuid: 'n1') }
  let!(:node_2) { MetaStruct::Graph::Node.create(uuid: 'n2') }
  let!(:node_3) { MetaStruct::Graph::Node.create(uuid: 'n3') }
  let!(:node_4) { MetaStruct::Graph::Node.create(uuid: 'n4') }
  let!(:node_5) { MetaStruct::Graph::Node.create(uuid: 'n5') }
  let!(:node_6) { MetaStruct::Graph::Node.create(uuid: 'n6') }

  let!(:edge_1) { MetaStruct::Graph::Edge.create(left_node: node_1, right_node: node_2) }
  let!(:edge_2) { MetaStruct::Graph::Edge.create(left_node: node_2, right_node: node_3) }
  let!(:edge_3) { MetaStruct::Graph::Edge.create(left_node: node_3, right_node: node_4) }
  let!(:edge_4) { MetaStruct::Graph::Edge.create(left_node: node_3, right_node: node_5) }
  let!(:edge_5) { MetaStruct::Graph::Edge.create(left_node: node_5, right_node: node_6) }
  let!(:edge_6) { MetaStruct::Graph::Edge.create(left_node: node_4, right_node: node_6) }

  let!(:graph) do
    MetaStruct::Graph.create(
      nodes: [node_1, node_2, node_3, node_4, node_5, node_6],
      edges: [edge_1, edge_2, edge_3, edge_4, edge_5, edge_6]
    )
    # garph:
    #   1->2,2->3,3->4->6
    #                ->>6
    #             3->5->6
  end

  describe 'algorithms (#find/#find!): find point (by uuid)' do
    context 'when node with required UUID is exist' do
      specify 'returns appropriated point' do
        aggregate_failures 'non-exceptional #find(...)' do
          # find node with UUID 'n1'
          expect(graph.find('n1')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_1)
          )

          # find node with UUID 'n2'
          expect(graph.find('n2')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_2)
          )

          # find node with UUID 'n3'
          expect(graph.find('n3')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_3)
          )

          # find node with UUID 'n4'
          expect(graph.find('n4')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_4)
          )

          # find node with UUID 'n5'
          expect(graph.find('n5')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_5)
          )

          # find node with UUID 'n6'
          expect(graph.find('n6')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_6)
          )
        end

        aggregate_failures 'exceptional #find(...)' do
          # find node with UUID 'n1'
          expect(graph.find!('n1')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_1)
          )

          # find node with UUID 'n2'
          expect(graph.find!('n2')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_2)
          )

          # find node with UUID 'n3'
          expect(graph.find!('n3')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_3)
          )

          # find node with UUID 'n4'
          expect(graph.find!('n4')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_4)
          )

          # find node with UUID 'n5'
          expect(graph.find!('n5')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_5)
          )

          # find node with UUID 'n6'
          expect(graph.find!('n6')).to(
            be_a(MetaStruct::Graph::Point) & have_attributes(node: node_6)
          )
        end
      end
    end

    context 'when node with required UUID does not exist' do
      specify 'returns nil (#find(...)) or fails with exception (#find!(...))' do
        aggregate_failures 'non-exceptional #find(...) -> nil' do
          expect(graph.find('blablabla_1')).to eq(nil)
          expect(graph.find('blablabla_2')).to eq(nil)
        end

        aggregate_failures 'exceptional #find!(...) -> exception' do
          expect { graph.find!('blablabla_1') }.to raise_error(
            MetaStruct::Graph::PointNotFoundError
          )
          expect { graph.find!('blablabla_2') }.to raise_error(
            MetaStruct::Graph::PointNotFoundError
          )
        end
      end
    end
  end
end
