# frozen_string_literal: true

require('circuits/modified_nodal_analysis/voltage_incidence_matrix')
require('circuits/modified_nodal_analysis/zero_matrix')
require('circuits/nodal_analysis/conductance_matrix')
require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class AMatrix < SimpleDelegator
      attr_reader :components

      def initialize(components)
        @components = components
        super(a_matrix)
      end

      def nodal_analysis_conductance_matrix
        NodalAnalysis::ConductanceMatrix.new(components)
      end

      def modified_nodal_analysis_voltage_incidence_matrix
        ModifiedNodalAnalysis::VoltageIncidenceMatrix.new(components)
      end

      def modified_nodal_analysis_zero_matrix
        ModifiedNodalAnalysis::ZeroMatrix.new(components)
      end

      private

      def a_matrix
        Matrix.vstack(
          Matrix.hstack(
            nodal_analysis_conductance_matrix,
            modified_nodal_analysis_voltage_incidence_matrix
          ),
          Matrix.hstack(
            modified_nodal_analysis_voltage_incidence_matrix.transpose,
            modified_nodal_analysis_zero_matrix
          )
        )
      end
    end
  end
end
