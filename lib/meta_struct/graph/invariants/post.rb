# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants::Post
  require_relative 'post/has_no_cycles'
  require_relative 'post/all'
end
