# frozen_string_literal: true

# @api public
# @since 0.1.0
class MetaStruct::Graph::Node
  require_relative 'node/uuid_generator'
  require_relative 'node/factory'

  class << self
    # @option uuid [String, nil]
    # @option labels [Array<String,Symbol>]
    # @option properties [Hash<String|Symbol,Any>]
    # @return [MetaStruct::Graph::Node]
    #
    # @api public
    # @since 0.1.0
    # rubocop:disable Layout/LineLength
    def create(uuid: Factory::AUTO_GENERATED_UUID, labels: Factory::NO_LABELS, properties: Factory::NO_PROPERTIES)
      Factory.create(uuid: uuid, labels: labels, properties: properties)
    end
    # rubocop:enable Layout/LineLength
  end

  # @return [Hash<String,Any>]
  #
  # @api public
  # @since 0.1.0
  attr_reader :properties

  # @return [Array<String>]
  #
  # @api public
  # @since 0.1.0
  attr_reader :labels

  # @return [String]
  #
  # @api public
  # @since 0.1.0
  attr_reader :uuid

  # @option uuid [String]
  # @option labels [Array<String>]
  # @option properties [Hash<String,Any>]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(uuid:, labels:, properties:)
    @uuid = uuid
    @labels = labels
    @properties = properties
  end
end
