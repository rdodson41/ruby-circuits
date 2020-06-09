# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class VoltageIncidenceMatrix < SimpleDelegator
      attr_reader :components
      attr_reader :nodes_indices

      def initialize(components, nodes_indices)
        @components = components
        @nodes_indices = nodes_indices
        super(zero_matrix)
        apply_voltage_incidence
      end

      def voltage_sources_count
        @voltage_sources_count ||= components.count(&:voltage_source?)
      end

      def [](row, column)
        super(nodes_indices[row], column)
      end

      def []=(row, column, value)
        super(nodes_indices[row], column, value)
      end

      private

      def zero_matrix
        Matrix.zero(nodes_indices.size, voltage_sources_count)
      end

      def apply_voltage_incidence
        components.select(&:voltage_source?).each.with_index do |component, index|
          self[component.nodes[0], index] -= 1
          self[component.nodes[1], index] += 1
        end
      end
    end
  end
end
