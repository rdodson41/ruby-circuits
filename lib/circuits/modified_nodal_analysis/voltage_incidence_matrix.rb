# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class VoltageIncidenceMatrix < SimpleDelegator
      attr_reader :voltage_sources
      attr_reader :nodes_indices

      def initialize(voltage_sources, nodes_indices)
        @voltage_sources = voltage_sources
        @nodes_indices = nodes_indices
        super(zero_matrix)
        apply_voltage_incidence
      end

      def [](row, column)
        super(nodes_indices[row], column)
      end

      def []=(row, column, value)
        super(nodes_indices[row], column, value)
      end

      private

      def zero_matrix
        Matrix.zero(nodes_indices.size, voltage_sources.count)
      end

      def apply_voltage_incidence
        voltage_sources.each.with_index do |voltage_source, index|
          self[voltage_source.nodes[0], index] -= 1
          self[voltage_source.nodes[1], index] += 1
        end
      end
    end
  end
end
