# frozen_string_literal: true

require 'securerandom'
require 'smart_core/container'
require 'smart_core/injection'

# @api public
# @since 0.1.0
module MetaStruct
  require_relative 'meta_struct/version'
  require_relative 'meta_struct/errors'
  require_relative 'meta_struct/graph'
end
