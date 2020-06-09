# frozen_string_literal: true

require('circuits/modified_nodal_analysis/voltage_incidence_matrix')
require('circuits/nodal_analysis/conductance_matrix')
require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class AMatrix < SimpleDelegator
      attr_reader :conductors
      attr_reader :voltage_sources
      attr_reader :nodes_indices

      def initialize(conductors, voltage_sources, nodes_indices)
        @conductors = conductors
        @voltage_sources = voltage_sources
        @nodes_indices = nodes_indices
        super(a_matrix)
      end

      def conductance_matrix
        NodalAnalysis::ConductanceMatrix.new(conductors, nodes_indices)
      end

      def voltage_incidence_matrix
        ModifiedNodalAnalysis::VoltageIncidenceMatrix.new(voltage_sources, nodes_indices)
      end

      def zero_matrix
        Matrix.zero(voltage_sources.count)
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
