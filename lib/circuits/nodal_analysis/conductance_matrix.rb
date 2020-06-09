# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module NodalAnalysis
    class ConductanceMatrix < SimpleDelegator
      attr_reader :components

      def initialize(components)
        @components = components
        super(zero_matrix)
        apply_conductance
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
        Matrix.zero(nodes_count)
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
