# frozen_string_literal: true

require('circuits/nodal_analysis/current_matrix')
require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class BMatrix < SimpleDelegator
      attr_reader :current_sources
      attr_reader :voltage_sources
      attr_reader :nodes_indices

      def initialize(current_sources, voltage_sources, nodes_indices)
        @current_sources = current_sources
        @voltage_sources = voltage_sources
        @nodes_indices = nodes_indices
        super(b_matrix)
      end

      def current_matrix
        NodalAnalysis::CurrentMatrix.new(current_sources, nodes_indices)
      end

      def voltage_matrix
        Matrix.column_vector(voltages)
      end

      private

      def voltages
        voltage_sources.map(&:voltage)
      end

      def b_matrix
        Matrix.vstack(current_matrix, voltage_matrix)
      end
    end
  end
end
