# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants::Pre
  require_relative 'pre/all'
  require_relative 'pre/has_only_one_root'
  require_relative 'pre/has_at_least_one_exit'
  require_relative 'pre/has_no_nonconnected_nodes'
end
