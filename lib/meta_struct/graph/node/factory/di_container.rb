# frozen_string_literal: true

MetaStruct::Graph::Node::Factory::DIContainer = SmartCore::Container.define do
  register(:uuid_generator) { MetaStruct::Graph::Node::UUIDGenerator }
end
