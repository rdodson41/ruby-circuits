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
      attr_reader :nodes_indices

      def initialize(components, nodes_indices)
        @components = components
        @nodes_indices = nodes_indices
        super(a_matrix)
      end

      def conductance_matrix
        NodalAnalysis::ConductanceMatrix.new(components, nodes_indices)
      end

      def voltage_incidence_matrix
        ModifiedNodalAnalysis::VoltageIncidenceMatrix.new(components, nodes_indices)
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
