# frozen_string_literal: true

module MetaStruct
  # @return [Class<StandardError>]
  Error = Class.new(::StandardError)

  # @return [Class<ArgumentError>]
  ArgumentError = Class.new(::ArgumentError)
end
