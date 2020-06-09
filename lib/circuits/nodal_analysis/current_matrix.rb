# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module NodalAnalysis
    class CurrentMatrix < SimpleDelegator
      attr_reader :current_sources
      attr_reader :nodes_indices

      def initialize(current_sources, nodes_indices)
        @current_sources = current_sources
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
        current_sources.each do |current_source|
          self[current_source.nodes[0]] -= current_source.current
          self[current_source.nodes[1]] += current_source.current
        end
      end
    end
  end
end
