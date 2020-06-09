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

      def conductance_matrix
        NodalAnalysis::ConductanceMatrix.new(components)
      end

      def voltage_incidence_matrix
        ModifiedNodalAnalysis::VoltageIncidenceMatrix.new(components)
      end

      def zero_matrix
        ModifiedNodalAnalysis::ZeroMatrix.new(components)
      end

      private

      def a_matrix
        Matrix.vstack(
          Matrix.hstack(conductance_matrix, voltage_incidence_matrix),
          Matrix.hstack(voltage_incidence_matrix.transpose, zero_matrix)
        )
      end
    end
  end
end
