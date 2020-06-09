# frozen_string_literal: true

require('circuits/modified_nodal_analysis/a_matrix')
require('circuits/modified_nodal_analysis/b_matrix')
require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class XMatrix < SimpleDelegator
      attr_reader :conductors
      attr_reader :current_sources
      attr_reader :voltage_sources
      attr_reader :nodes_indices

      def initialize(conductors, current_sources, voltage_sources, nodes_indices)
        @conductors = conductors
        @current_sources = current_sources
        @voltage_sources = voltage_sources
        @nodes_indices = nodes_indices
        super(x_matrix)
      end

      def a_matrix
        ModifiedNodalAnalysis::AMatrix.new(conductors, voltage_sources, nodes_indices)
      end

      def b_matrix
        ModifiedNodalAnalysis::BMatrix.new(current_sources, voltage_sources, nodes_indices)
      end

      private

      def x_matrix
        a_matrix.inverse * b_matrix.to_matrix
      end
    end
  end
end
