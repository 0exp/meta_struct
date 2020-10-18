# frozen_string_literal: true

module MetaStruct
  # @return [Class<::StandardError>]
  #
  # @pai public
  # @since 0.1.0
  Error = Class.new(::StandardError)

  # @return [Class<::ArgumentError>]
  #
  # @pai public
  # @since 0.1.0
  ArgumentError = Class.new(::ArgumentError)
end
