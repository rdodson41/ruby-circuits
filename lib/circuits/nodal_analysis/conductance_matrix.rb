# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module NodalAnalysis
    class ConductanceMatrix < SimpleDelegator
      attr_reader :components
      attr_reader :nodes_indices

      def initialize(components, nodes_indices)
        @components = components
        @nodes_indices = nodes_indices
        super(zero_matrix)
        apply_conductance
      end

      def [](row, column)
        super(nodes_indices[row], nodes_indices[column])
      end

      def []=(row, column, value)
        super(nodes_indices[row], nodes_indices[column], value)
      end

      private

      def zero_matrix
        Matrix.zero(nodes_indices.size)
      end

      def apply_conductance
        components.select(&:conductor?).each do |component|
          component.nodes.each do |node|
            self[node, node] += component.conductance
          end
          component.nodes.permutation(2).each do |nodes|
            self[nodes[0], nodes[1]] -= component.conductance
          end
        end
      end
    end
  end
end
