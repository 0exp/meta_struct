# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants
  require_relative 'invariants/has_one_root'
  require_relative 'invariants/has_no_cycles'
  require_relative 'invariants/has_no_nonconnected_nodes'
  require_relative 'invariants/all'
end
