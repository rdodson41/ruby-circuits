# frozen_string_literal: true

require('circuits/modified_nodal_analysis/voltage_matrix')
require('circuits/nodal_analysis/current_matrix')
require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class BMatrix < SimpleDelegator
      attr_reader :components

      def initialize(components)
        @components = components
        super(b_matrix)
      end

      def nodal_analysis_current_matrix
        NodalAnalysis::CurrentMatrix.new(components)
      end

      def modified_nodal_analysis_voltage_matrix
        ModifiedNodalAnalysis::VoltageMatrix.new(components)
      end

      private

      def b_matrix
        Matrix.vstack(
          nodal_analysis_current_matrix,
          modified_nodal_analysis_voltage_matrix
        )
      end
    end
  end
end
