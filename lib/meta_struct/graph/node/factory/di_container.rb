# frozen_string_literal: true

# @api public
# @since 0.1.0
MetaStruct::Graph::Node::Factory::DIContainer = SmartCore::Container.define do
  register(:uuid_generator) { MetaStruct::Graph::Node::UUIDGenerator }
end
