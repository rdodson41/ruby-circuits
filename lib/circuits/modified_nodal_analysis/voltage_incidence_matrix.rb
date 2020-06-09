# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class VoltageIncidenceMatrix < SimpleDelegator
      attr_reader :components

      def initialize(components)
        @components = components
        super(zero_matrix)
        apply_voltage_incidence
      end

      def nodes
        @nodes ||= components.flat_map(&:nodes).uniq
      end

      def nodes_count
        @nodes_count ||= nodes.count
      end

      def voltage_sources_count
        @voltage_sources_count ||= components.count(&:voltage_source?)
      end

      def nodes_indices
        @nodes_indices ||= nodes.map.with_index.to_h
      end

      def [](row, column)
        super(nodes_indices[row], column)
      end

      def []=(row, column, value)
        super(nodes_indices[row], column, value)
      end

      private

      def zero_matrix
        Matrix.zero(nodes_count, voltage_sources_count)
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
