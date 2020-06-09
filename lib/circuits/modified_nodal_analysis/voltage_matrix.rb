# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class VoltageMatrix < SimpleDelegator
      attr_reader :components

      def initialize(components)
        @components = components
        super(zero_matrix)
        apply_voltage
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

      def [](row)
        super(row, 0)
      end

      def []=(row, value)
        super(row, 0, value)
      end

      private

      def zero_matrix
        Matrix.zero(voltage_sources_count, 1)
      end

      def apply_voltage
        components.select(&:voltage_source?).each.with_index do |component, index|
          self[index] = component.voltage
        end
      end
    end
  end
end
