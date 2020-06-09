# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class VoltageMatrix < SimpleDelegator
      attr_reader :voltage_sources

      def initialize(voltage_sources)
        @voltage_sources = voltage_sources
        super(zero_matrix)
        apply_voltage
      end

      def [](row)
        super(row, 0)
      end

      def []=(row, value)
        super(row, 0, value)
      end

      private

      def zero_matrix
        Matrix.zero(voltage_sources.count, 1)
      end

      def apply_voltage
        voltage_sources.each.with_index do |voltage_source, index|
          self[index] = voltage_source.voltage
        end
      end
    end
  end
end
