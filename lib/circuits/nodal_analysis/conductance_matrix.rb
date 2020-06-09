# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module NodalAnalysis
    class ConductanceMatrix < SimpleDelegator
      attr_reader :conductors
      attr_reader :nodes_indices

      def initialize(conductors, nodes_indices)
        @conductors = conductors
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
        conductors.each do |conductor|
          conductor.nodes.each do |node|
            self[node, node] += conductor.conductance
          end
          conductor.nodes.permutation(2).each do |nodes|
            self[nodes[0], nodes[1]] -= conductor.conductance
          end
        end
      end
    end
  end
end
