# frozen_string_literal: true

RSpec.describe MetaStruct::Graph::Node do
  describe 'creation' do
    specify 'fails on invalid labels' do
      aggregate_failures 'invalid labels' do
        expect do # not an array
          MetaStruct::Graph::Node.create(labels: 'test')
        end.to raise_error(MetaStruct::Graph::InvalidNodeLabelsError)

        expect do # a collection of non-string objects
          MetaStruct::Graph::Node.create(labels: [Object.new])
        end.to raise_error(MetaStruct::Graph::InvalidNodeLabelsError)

        expect do # not an array of strings
          MetaStruct::Graph::Node.create(labels: ['test', 123])
        end.to raise_error(MetaStruct::Graph::InvalidNodeLabelsError)

        expect do # an array of strings - good
          MetaStruct::Graph::Node.create(labels: %w[test no_test])
        end.not_to raise_error

        expect do # an array of strings and symbols - good
          MetaStruct::Graph::Node.create(labels: ['test', :no_test])
        end.not_to raise_error

        expect do # an array of symbols - good
          MetaStruct::Graph::Node.create(labels: %i[test no_test])
        end.not_to raise_error

        expect do # empty array of labels - good
          MetaStruct::Graph::Node.create(labels: [])
        end.not_to raise_error

        expect do # labels are not provided - good
          MetaStruct::Graph::Node.create
        end.not_to raise_error
      end
    end

    specify 'fails on invalid properties' do
      aggregate_failures 'invalid properties' do
        expect do # not a hash
          MetaStruct::Graph::Node.create(properties: 'test')
        end.to raise_error(MetaStruct::Graph::InvalidNodePropertiesError)

        expect do # hash with non-string/non-symbol keys
          MetaStruct::Graph::Node.create(properties: { Object.new => 'test' })
        end.to raise_error(MetaStruct::Graph::InvalidNodePropertiesError)

        expect do # hash with string keys - good
          MetaStruct::Graph::Node.create(properties: { 'a' => 1, 'b' => Object.new })
        end.not_to raise_error

        expect do # hash with symbol kesy - good
          MetaStruct::Graph::Node.create(properties: { a: 1, b: Object.new })
        end.not_to raise_error

        expect do # hash with both string and symbol keys - good
          MetaStruct::Graph::Node.create(properties: { :a => 1, 'b' => Object.new })
        end.not_to raise_error

        expect do # properties are not provided - good
          MetaStruct::Graph::Node.create
        end.not_to raise_error
      end
    end
  end
end
