# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module NodalAnalysis
    class CurrentMatrix < SimpleDelegator
      attr_reader :components

      def initialize(components)
        @components = components
        super(zero_matrix)
        apply_current
      end

      def nodes
        @nodes ||= components.flat_map(&:nodes).uniq
      end

      def nodes_count
        @nodes_count ||= nodes.count
      end

      def nodes_indices
        @nodes_indices ||= nodes.map.with_index.to_h
      end

      def [](row, column)
        super(nodes_indices[row], nodes_indices[column])
      end

      def []=(row, column, value)
        super(nodes_indices[row], nodes_indices[column], value)
      end

      private

      def zero_matrix
        Matrix.zero(nodes_count, 1)
      end

      def apply_current
        components.select(&:current_source?).each do |component|
          self[component.nodes[0], 0] += component.current
          self[component.nodes[1], 0] -= component.current
        end
      end
    end
  end
end
