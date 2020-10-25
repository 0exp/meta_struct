# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Edge do
  let(:left_node) { MetaStruct::Graph::Node.create }
  let(:right_node) { MetaStruct::Graph::Node.create }
  let(:node_attrs) { { left_node: left_node, right_node: right_node } }

  describe 'creation failures' do
    specify 'all nodes should be provided' do
      aggregate_failures 'node insufficiency' do
        expect do
          MetaStruct::Graph::Edge.create(left_node: left_node)
        end.to raise_error(MetaStruct::Graph::EdgeNodeInsufficiencyError)

        expect do
          MetaStruct::Graph::Edge.create(right_node: right_node)
        end.to raise_error(MetaStruct::Graph::EdgeNodeInsufficiencyError)

        expect do
          MetaStruct::Graph::Edge.create(left_node: nil, right_node: nil)
        end.to raise_error(MetaStruct::Graph::EdgeNodeInsufficiencyError)

        expect do
          MetaStruct::Graph::Edge.create
        end.to raise_error(MetaStruct::Graph::EdgeNodeInsufficiencyError)
      end
    end

    specify 'fails when provided node is not a type of graph node' do
      aggregate_failures 'invalid nodes' do
        expect do
          MetaStruct::Graph::Edge.create(left_node: Object.new, right_node: right_node)
        end.to raise_error(MetaStruct::Graph::InvalidEdgeNodeError)

        expect do
          MetaStruct::Graph::Edge.create(left_node: left_node, right_node: Object.new)
        end.to raise_error(MetaStruct::Graph::InvalidEdgeNodeError)

        expect do
          MetaStruct::Graph::Edge.create(left_node: Object.new, right_node: Object.new)
        end.to raise_error(MetaStruct::Graph::InvalidEdgeNodeError)
      end
    end

    specify 'fails while weight is not an integer (allows positive, negative and zero integers)' do
      aggregate_failures 'invalid weight' do
        expect do
          MetaStruct::Graph::Edge.create(**node_attrs, weight: Object.new)
        end.to raise_error(MetaStruct::Graph::InvalidEdgeWeightError)

        expect do
          MetaStruct::Graph::Edge.create(**node_attrs, weight: '500')
        end.to raise_error(MetaStruct::Graph::InvalidEdgeWeightError)

        expect { MetaStruct::Graph::Edge.create(**node_attrs, weight: 0) }.not_to raise_error
        expect { MetaStruct::Graph::Edge.create(**node_attrs, weight: -1) }.not_to raise_error
        expect { MetaStruct::Graph::Edge.create(**node_attrs, weight: +1) }.not_to raise_error
      end
    end

    specify 'fails on invalid labels' do
      aggregate_failures 'invalid labels' do
        expect do # not an array
          MetaStruct::Graph::Edge.create(**node_attrs, labels: 'test')
        end.to raise_error(MetaStruct::Graph::InvalidEdgeLabelsError)

        expect do # a collection of non-string objects
          MetaStruct::Graph::Edge.create(**node_attrs, labels: [Object.new])
        end.to raise_error(MetaStruct::Graph::InvalidEdgeLabelsError)

        expect do # not an array of strings
          MetaStruct::Graph::Edge.create(**node_attrs, labels: ['test', 123])
        end.to raise_error(MetaStruct::Graph::InvalidEdgeLabelsError)

        expect do # an array of strings - good
          MetaStruct::Graph::Edge.create(**node_attrs, labels: %w[test no_test])
        end.not_to raise_error

        expect do # an array of strings and symbols - good
          MetaStruct::Graph::Edge.create(**node_attrs, labels: ['test', :no_test])
        end.not_to raise_error

        expect do # an array of symbols - good
          MetaStruct::Graph::Edge.create(**node_attrs, labels: %i[test no_test])
        end.not_to raise_error

        expect do # empty array of labels - good
          MetaStruct::Graph::Edge.create(**node_attrs, labels: [])
        end.not_to raise_error

        expect do # labels are not provided - good
          MetaStruct::Graph::Edge.create(**node_attrs)
        end.not_to raise_error
      end
    end

    specify 'fails on invalid properties' do
      aggregate_failures 'invalid properties' do
        expect do # not a hash
          MetaStruct::Graph::Edge.create(**node_attrs, properties: 'test')
        end.to raise_error(MetaStruct::Graph::InvalidEdgePropertiesError)

        expect do # hash with non-string/non-symbol keys
          MetaStruct::Graph::Edge.create(**node_attrs, properties: { Object.new => 'test' })
        end.to raise_error(MetaStruct::Graph::InvalidEdgePropertiesError)

        expect do # hash with string keys - good
          MetaStruct::Graph::Edge.create(**node_attrs, properties: { 'a' => 1, 'b' => Object.new })
        end.not_to raise_error

        expect do # hash with symbol kesy - good
          MetaStruct::Graph::Edge.create(**node_attrs, properties: { a: 1, b: Object.new })
        end.not_to raise_error

        expect do # hash with both string and symbol keys - good
          MetaStruct::Graph::Edge.create(**node_attrs, properties: { :a => 1, 'b' => Object.new })
        end.not_to raise_error

        expect do # properties are not provided - good
          MetaStruct::Graph::Edge.create(**node_attrs)
        end.not_to raise_error
      end
    end
  end

  describe 'common instance creation and state access' do
    specify 'commonly created edge (default state)' do
      edge = MetaStruct::Graph::Edge.create(left_node: left_node, right_node: right_node)

      expect(edge.weight).to eq(0)
      expect(edge.labels).to eq([])
      expect(edge.properties).to eq({})
      expect(edge.left_node).to eq(left_node)
      expect(edge.right_node).to eq(right_node)

      expect(edge.labels.frozen?).to eq(true)
      expect(edge.properties.frozen?).to eq(true)
    end

    specify 'commonly created edge (with custom attributes)' do
      edge_a = MetaStruct::Graph::Edge.create(
        left_node: left_node,
        right_node: right_node,
        labels: %w[weighted directed],
        properties: { a: 'new_test', b: 2, c: 3.0 },
        weight: -1
      )

      edge_b = MetaStruct::Graph::Edge.create(
        left_node: right_node,
        right_node: left_node,
        labels: %w[newest games],
        properties: { d: 4, e: 5.0, f: 'test' },
        weight: 10
      )

      expect(edge_a.weight).to eq(-1)
      expect(edge_a.labels).to contain_exactly('weighted', 'directed')
      expect(edge_a.properties).to match('a' => 'new_test', 'b' => 2, 'c' => 3.0)
      expect(edge_a.left_node).to eq(left_node)
      expect(edge_a.right_node).to eq(right_node)

      expect(edge_a.labels.frozen?).to eq(true)
      expect(edge_a.properties.frozen?).to eq(true)

      expect(edge_b.weight).to eq(10)
      expect(edge_b.labels).to contain_exactly('newest', 'games')
      expect(edge_b.properties).to match('d' => 4, 'e' => 5.0, 'f' => 'test')
      expect(edge_b.left_node).to eq(right_node)
      expect(edge_b.right_node).to eq(left_node)

      expect(edge_b.labels.frozen?).to eq(true)
      expect(edge_b.properties.frozen?).to eq(true)
    end

    specify 'labels automatically transforms to strings' do
      edge = MetaStruct::Graph::Edge.create(**node_attrs, labels: ['a', :b, 'c', :d])
      expect(edge.labels).to contain_exactly('a', 'b', 'c', 'd')
    end

    specify 'property keys automatically transforms to strings' do
      edge = MetaStruct::Graph::Edge.create(
        **node_attrs, properties: { a: 1, 'b' => 2, c: 3, 'd' => 4 }
      )
      expect(edge.properties).to match('a' => 1, 'b' => 2, 'c' => 3, 'd' => 4)
    end
  end
end
