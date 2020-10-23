# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Points::BuildTree do
  let(:build) { described_class.call(nodes, edges) }

  let(:nodes) do
    [root_1, root_2, child_for_root_1, another_child_for_root_1, child_for_root_2]
  end
  let(:edges) do
    [child_edge_for_root_1, another_child_edge_for_root_1, child_edge_for_root_2]
  end

  let(:root_1) { MetaStruct::Graph::Node.create }
  let(:root_2) { MetaStruct::Graph::Node.create }
  let(:child_for_root_1) { MetaStruct::Graph::Node.create }
  let(:another_child_for_root_1) { MetaStruct::Graph::Node.create }
  let(:child_for_root_2) { MetaStruct::Graph::Node.create }

  let(:child_edge_for_root_1) do
    MetaStruct::Graph::Edge.create(
      left_node: root_1,
      right_node: child_for_root_1
    )
  end
  let(:another_child_edge_for_root_1) do
    MetaStruct::Graph::Edge.create(
      left_node: root_1,
      right_node: another_child_for_root_1
    )
  end
  let(:child_edge_for_root_2) do
    MetaStruct::Graph::Edge.create(
      left_node: root_2,
      right_node: child_for_root_2
    )
  end

  describe 'root points cointain correct nodes' do
    subject { build.map(&:node) }

    let(:expected_result) { [root_1, root_2] }

    it { is_expected.to match_array(expected_result) }
  end

  describe 'points contain correct children' do
    subject do
      build.map { |point| point.children.map(&:node) }
    end

    let(:expected_result) do
      [
        [child_for_root_1, another_child_for_root_1],
        [child_for_root_2]
      ]
    end

    it { is_expected.to match_array(expected_result) }
  end
end