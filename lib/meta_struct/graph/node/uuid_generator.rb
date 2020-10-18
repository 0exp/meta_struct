# frozen_string_literal: true

# @api public
# @since 0.1.0
module MetaStruct::Graph::Node::UUIDGenerator
  class << self
    # @return [String]
    #
    # @api public
    # @since 0.1.0
    def call
      ::SecureRandom.uuid
    end
  end
end
