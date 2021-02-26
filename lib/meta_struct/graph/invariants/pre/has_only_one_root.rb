# frozen_string_literal: true

# @api private
# @since 0.1.0
module MetaStruct::Graph::Invariants::Pre::HasOnlyOneRoot
  class << self
    # @since 0.1.0
    include SmartCore::Injection(::MetaStruct::DIContainer)

    # @since 0.1.0
    import(
      { find_root_nodes: 'graph.algorithms.find_root_nodes' },
      bind: :dynamic,
      access: :private
    )

    # @param nodes [Array<MetaStruct::Graph::Node>]
    # @param edges [Array<MetaStruct::Graph::Edge>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def validate!(nodes, edges)
      root_nodes = find_root_nodes.call(nodes, edges)

      case
      when root_nodes.size == 0
        raise(
          MetaStruct::Graph::RootNotFoundInvariantError,
          'Your graph has no root node.'
        )
      when root_nodes.size != 1
        raise(
          MetaStruct::Graph::MoreThanOneRootInvariantError,
          "Your graph has more than one root (you can have only one root in graph entity). " \
          "Root node UUIDs: #{root_nodes.map(&:uuid).join(', ')}."
        )
      end
    end
  end
end
