# frozen_string_literal: true

require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class ZeroMatrix < SimpleDelegator
      attr_reader :components

      def initialize(components)
        @components = components
        super(zero_matrix)
      end

      def voltage_sources_count
        @voltage_sources_count ||= components.count(&:voltage_source?)
      end

      private

      def zero_matrix
        Matrix.zero(voltage_sources_count)
      end
    end
  end
end
