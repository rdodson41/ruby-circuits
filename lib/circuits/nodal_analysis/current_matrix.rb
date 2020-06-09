# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module NodalAnalysis
    class CurrentMatrix < SimpleDelegator
      attr_reader :components
      attr_reader :nodes_indices

      def initialize(components, nodes_indices)
        @components = components
        @nodes_indices = nodes_indices
        super(zero_matrix)
        apply_current
      end

      def [](row)
        super(nodes_indices[row], 0)
      end

      def []=(row, value)
        super(nodes_indices[row], 0, value)
      end

      private

      def zero_matrix
        Matrix.zero(nodes_indices.size, 1)
      end

      def apply_current
        components.select(&:current_source?).each do |component|
          self[component.nodes[0]] -= component.current
          self[component.nodes[1]] += component.current
        end
      end
    end
  end
end
