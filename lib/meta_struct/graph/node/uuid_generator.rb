# frozen_string_literal: true

module MetaStruct::Graph::Node::UUIDGenerator
  class << self
    # @return [String]
    def call
      ::SecureRandom.uuid
    end
  end
end
